import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/usecases/file_picker_usecase/file_picker_usecase.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'telegram_file_picker_events.dart';
import 'telegram_file_picker_state.dart';

@immutable
class TelegramFilePickerBloc {
  static late FilePickerUseCase _filePickerUseCase;

  //
  static late TelegramFilePickerStateModel _currentStateModel;
  static late BehaviorSubject<TelegramFilePickerStates> _currentState; // emitter usage only
  static late Sink<TelegramFilePickerEvents> _events;

  final Sink<TelegramFilePickerEvents> events;
  final BehaviorSubject<TelegramFilePickerStates> _states;

  BehaviorSubject<TelegramFilePickerStates> get states => _states;

  void dispose() {
    events.add(const ClosePopupEvent());
  }

  const TelegramFilePickerBloc._({
    required this.events,
    required BehaviorSubject<TelegramFilePickerStates> states,
  }) : _states = states;

  factory TelegramFilePickerBloc(
    TelegramFilePickerRepo telegramFilePickerRepo,
  ) {
    _filePickerUseCase = FilePickerUseCase(telegramFilePickerRepo);
    //
    _currentStateModel = TelegramFilePickerStateModel();

    final events = BehaviorSubject<TelegramFilePickerEvents>();

    final streamOfEvents = events.switchMap<TelegramFilePickerStates>((events) async* {
      yield* _streamHandler(events);
    }).startWith(
      GalleryFilePickerState(_currentStateModel),
    );

    final behaviourSubjectFromStream = BehaviorSubject<TelegramFilePickerStates>()
      ..addStream(streamOfEvents);

    _currentState = behaviourSubjectFromStream;

    _events = events;

    return TelegramFilePickerBloc._(
      events: events.sink,
      states: behaviourSubjectFromStream,
    );
  }

  static Stream<TelegramFilePickerStates> _streamHandler(
    TelegramFilePickerEvents event,
  ) async* {
    if (event is JustEmitStateEvent) {
      yield* _emitter();
    } else if (event is InitAllPicturesEvent) {
      yield* _initAllPicturesEvent(event);
    } else if (event is InitAllFilesEvent) {
      yield* _initAllFilesEvent(event);
    } else if (event is InitAllMusicsEvent) {
      yield* _initAllMusicsEvent(event);
    } else if (event is ClosePopupEvent) {
      yield* _closePopupEvent(event);
    } else if (event is OpenHideBottomTelegramButtonEvent) {
      yield* _openHideBottomTelegramButtonEvent(event);
    } else if (event is FileStreamHandlerEvent) {
      yield* _fileStreamHandlerEvent(event);
    } else if (event is RecentFileStreamHandlerEvent) {
      yield* _recentFileStreamHandlerEvent(event);
    } else if (event is ImagesAndVideoPaginationEvent) {
      yield* _imagesAndVideoPaginationEvent();
    } else if (event is SelectGalleryFileEvent) {
      yield* _selectGalleryFileEvent(event);
    }
  }

  static Stream<TelegramFilePickerStates> _initAllPicturesEvent(
    InitAllPicturesEvent event,
  ) async* {
    _currentStateModel.clearAllGalleryPath(clearAll: false);
    _currentStateModel.clearAllGalleryPaginationPath(clearAll: false);

    debugPrint("length of gallery: ${_currentStateModel.galleryPathFiles.length}");
    debugPrint("length of gallery pag: ${_currentStateModel.galleryPathPagination.length}");

    try {
      if (_currentStateModel.galleryPathFiles.isEmpty) {
        final TelegramFileImageModel fileModel = TelegramFileImageModel(
          cameraController: CameraController(
            snoopy<CameraHelperService>().cameras.last,
            ResolutionPreset.max,
          ),
        );

        await fileModel.controllerInit();

        yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
          fileModel,
          emitter: _emitter(),
        );
      } else {
        debugPrint(
            "setting models length: ${_currentStateModel.galleryPathFiles.first.cameraController != null}");
        yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
          _currentStateModel.galleryPathFiles.first,
          emitter: _emitter(),
        );
      }

      debugPrint("length of gallery: ${_currentStateModel.galleryPathFiles.length}");
      debugPrint("length of gallery pag: ${_currentStateModel.galleryPathPagination.length}");

      _currentStateModel.initFileStreamData(
        _filePickerUseCase.getRecentImagesAndVideos().listen(
          (value) {
            _events.add(FileStreamHandlerEvent(value));
          },
        )..onDone(() {
            //
            debugPrint("im done!");
          }),
      );

      yield GalleryFilePickerState(_currentStateModel);
    } catch (e) {
      debugPrint("ini all pictures event is: $e");
    }
  }

  //

  static Stream<TelegramFilePickerStates> _initAllFilesEvent(
    InitAllFilesEvent event,
  ) async* {
    _currentStateModel.initFileStreamData(
      _filePickerUseCase.downloadsPathFilesData().listen((e) {
        _events.add(RecentFileStreamHandlerEvent(e));
      }),
    );

    yield FilesPickerState(_currentStateModel);
  }

  //
  static Stream<TelegramFilePickerStates> _initAllMusicsEvent(
    InitAllMusicsEvent event,
  ) async* {}

  static Stream<TelegramFilePickerStates> _openHideBottomTelegramButtonEvent(
    OpenHideBottomTelegramButtonEvent event,
  ) async* {
    if ((_currentStateModel.openButtonSectionTimer?.isActive ?? false)) {
      _currentStateModel.openButtonSectionTimer?.cancel();
    }
    _currentStateModel.setOpenButtonSectionTimer(Timer(
      const Duration(milliseconds: 350),
      () {
        _currentStateModel.setValueToOpenButtonSectionButton(event.value);
        _events.add(const JustEmitStateEvent());
      },
    ));
  }

  //
  static Stream<TelegramFilePickerStates> _fileStreamHandlerEvent(
    FileStreamHandlerEvent event,
  ) async* {
    if (event.file != null) {
      // it's not paginating logic
      // that is why this function should get stream of file
      // any time when it comes and
      // put it inside whole list
      // and should check the pagination list until specific length
      // and keep pushing that file inside that pagination list
      // until list reaches specific length of pagination
      final model = TelegramFileImageModel(
        file: event.file,
        videoPlayerController: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.path)
            ? VideoPlayerController.file(event.file!)
            : null,
        videoPreview: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      _currentStateModel.setGalleryPathFiles(model);

      yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
        model,
        emitter: _emitter(),
      );

      // yield* _emitter();
    }
  }

  //
  static Stream<TelegramFilePickerStates> _recentFileStreamHandlerEvent(
    RecentFileStreamHandlerEvent event,
  ) async* {
    if (event.file != null) {
      final model = TelegramFileImageModel(
        file: event.file,
        videoPlayerController: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.path)
            ? VideoPlayerController.file(event.file!)
            : null,
        fileName: basename(event.file!.path),
        videoPreview: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      _currentStateModel.addToRecentFiles(model);

      yield* _emitter();
    }
  }

  //
  static Stream<TelegramFilePickerStates> _imagesAndVideoPaginationEvent() async* {
    final tempList = snoopy<ListPaginationChecker>().paginateList(
      wholeList: _currentStateModel.galleryPathFiles,
      currentList: _currentStateModel.galleryPathPagination,
    );

    _currentStateModel.addToPagination(tempList);

    yield GalleryFilePickerState(_currentStateModel);
  }

  static Stream<TelegramFilePickerStates> _selectGalleryFileEvent(
    SelectGalleryFileEvent event,
  ) async* {
    _currentStateModel.removeOrAddEntity(event.telegramFileImageEntity);
    yield* _emitter();
  }

  //
  static Stream<TelegramFilePickerStates> _closePopupEvent(
    ClosePopupEvent event,
  ) async* {
    if (_currentStateModel.galleryPathFiles.firstOrNull?.cameraController != null) {
      _currentStateModel.galleryPathFiles.firstOrNull?.cameraController?.dispose();
    }
    for (final each in _currentStateModel.galleryPathFiles) {
      each.videoPlayerController?.dispose();
    }
    if (_currentStateModel.galleryPathPagination.firstOrNull?.cameraController != null) {
      _currentStateModel.galleryPathPagination.firstOrNull?.cameraController?.dispose();
    }
    for (final each in _currentStateModel.galleryPathPagination) {
      each.videoPlayerController?.dispose();
    }
    _currentStateModel.closeAllStreamSubs();
    _currentStateModel.clearAllGalleryPath();
    _currentStateModel.clearAllGalleryPaginationPath();
  }

  //

  //
  // emitter
  static Stream<TelegramFilePickerStates> _emitter() async* {
    if (_currentState.value is GalleryFilePickerState) {
      yield GalleryFilePickerState(_currentStateModel);
    } else if (_currentState.value is FilesPickerState) {
      yield FilesPickerState(_currentStateModel);
    } else if (_currentState.value is MusicFilesPickerState) {
      yield MusicFilesPickerState(_currentStateModel);
    }
  }
}
