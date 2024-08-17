import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
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
    } else if (event is ChangeStateToAllPicturesEvent) {
      yield GalleryFilePickerState(_currentStateModel);
    } else if (event is InitAllFilesEvent) {
      yield* _initAllFilesEvent(event);
    } else if (event is ChangeStateToAllFilesState) {
      yield FilesPickerState(_currentStateModel);
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
    } else if (event is RecentFilesPaginationEvent) {
      yield* _recentFilesPaginationEvent(event);
    } else if (event is SelectGalleryFileEvent) {
      yield* _selectGalleryFileEvent(event);
    } else if (event is BrowseInternalStorageAndSelectFilesEvent) {
      yield* _browseInternalStorageAndSelectFilesEvent(event);
    } else if (event is SelectScreenForFilesPickerScreenEvent) {
      yield* _selectScreenForFilesPickerScreenEvent(event);
    } else if (event is GetSpecificFolderDataEvent) {
      yield* _getSpecificFolderDataEvent(event);
    } else if (event is SpecificFolderDataStreamHandlerEvent) {
      yield* _specificFolderDataStreamHandlerEvent(event);
    } else if (event is SetSpecificFolderPathInOrderToGetDataFromThereEvent) {
      yield* _setSpecificFolderPathInOrderToGetDataFromThereEvent(event);
    }
  }

  static Stream<TelegramFilePickerStates> _initAllPicturesEvent(
    InitAllPicturesEvent event,
  ) async* {
    if (event.controller != null) {
      _currentStateModel.initDragScrollController(event.controller!);
    }
    _currentStateModel.clearAllGalleryPath(clearAll: false);
    _currentStateModel.clearAllGalleryPaginationPath(clearAll: false);

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
        yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
          _currentStateModel.galleryPathFiles.first,
          emitter: _emitter(),
        );
      }

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

      _events.add(const InitAllFilesEvent(initFilePickerState: false));

      yield GalleryFilePickerState(_currentStateModel);
    } catch (e) {
      debugPrint("ini all pictures event is: $e");
    }
  }

  //

  static Stream<TelegramFilePickerStates> _initAllFilesEvent(
    InitAllFilesEvent event,
  ) async* {
    _currentStateModel.clearRecentFiles();
    _currentStateModel.clearRecentPagFiles();
    _currentStateModel.initRecentFileStreamData(
      _filePickerUseCase.downloadsPathFilesData().listen((e) {
        _events.add(RecentFileStreamHandlerEvent(e));
      }),
    );

    if (event.initFilePickerState) {
      yield FilesPickerState(_currentStateModel);
    } else {
      yield* _emitter();
    }
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
    if (event.file != null && event.file?.file != null) {
      // it's not paginating logic
      // that is why this function should get stream of file
      // any time when it comes and
      // put it inside whole list
      // and should check the pagination list until specific length
      // and keep pushing that file inside that pagination list
      // until list reaches specific length of pagination
      final model = TelegramFileImageModel(
        file: event.file!.file,
        videoPlayerController: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.file.path)
            ? VideoPlayerController.file(event.file!.file)
            : null,
        videoPreview: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.file.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      if (model.videoPlayerController == null && model.videoPreview == null) {
        if (_currentStateModel.context.mounted) {
          // precacheImage(
          //   FileImage(event.file!),
          //   _currentStateModel.context,
          // );
        }
      }

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
    if (event.file != null && event.file?.file != null) {
      final model = TelegramFileImageModel(
        file: event.file?.file,
        videoPlayerController: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.file.path)
            ? VideoPlayerController.file(event.file!.file)
            : null,
        fileName: basename(event.file!.file.path),
        videoPreview: snoopy<ReusableGlobalFunctions>().isVideoFile(event.file!.file.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      if (model.videoPlayerController == null && model.videoPreview == null) {
        if (_currentStateModel.context.mounted) {
          // precacheImage(
          //   FileImage(event.file!),
          //   _currentStateModel.context,
          // );
        }
      }

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

    yield* _emitter();
  }

  static Stream<TelegramFilePickerStates> _selectGalleryFileEvent(
    SelectGalleryFileEvent event,
  ) async* {
    _currentStateModel.removeOrAddEntity(event.telegramFileImageEntity);
    yield* _emitter();
  }

  static Stream<TelegramFilePickerStates> _recentFilesPaginationEvent(
    RecentFilesPaginationEvent event,
  ) async* {
    final tempList = snoopy<ListPaginationChecker>().paginateList(
      wholeList: _currentStateModel.recentFiles,
      currentList: _currentStateModel.recentFilesPagination,
    );

    _currentStateModel.addToRecentFilesPagination(tempList);

    yield* _emitter();
  }

  //
  static Stream<TelegramFilePickerStates> _closePopupEvent(
    ClosePopupEvent event,
  ) async* {
    // await DefaultCacheManager().emptyCache();
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
  void resetDragScrollSheet() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _currentStateModel.draggableScrollableController?.animateTo(
        0.5,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  //
  static Stream<TelegramFilePickerStates> _browseInternalStorageAndSelectFilesEvent(
    BrowseInternalStorageAndSelectFilesEvent event,
  ) async* {
    final imagePicker = ImagePicker();
    final files = await imagePicker.pickMultipleMedia();
    if (files.isEmpty) return;
    // convert this files into
    final convertedData = files.map((e) => TelegramFileImageModel(file: File(e.path))).toList();
    for (final each in convertedData) {
      _currentStateModel.removeOrAddEntity(each);
    }
    yield* _emitter();
  }

  static Stream<TelegramFilePickerStates> _selectScreenForFilesPickerScreenEvent(
    SelectScreenForFilesPickerScreenEvent event,
  ) async* {
    _currentStateModel.selectScreen(event.screen);
    yield* _emitter();
  }

  //
  static Stream<TelegramFilePickerStates> _setSpecificFolderPathInOrderToGetDataFromThereEvent(
    SetSpecificFolderPathInOrderToGetDataFromThereEvent event,
  ) async* {
    if (event.path == null) return;
    _currentStateModel.setPathForGettingImagesFrom(event.path);
    _events.add(const GetSpecificFolderDataEvent());
    yield* _emitter();
  }

  //
  static Stream<TelegramFilePickerStates> _getSpecificFolderDataEvent(
    GetSpecificFolderDataEvent event,
  ) async* {
    if (_currentStateModel.getPathForGettingImagesFrom == null) return;
    _currentStateModel.clearSpecificFolderData();
    _currentStateModel.closeSpecificFolderDataStream();
    _currentStateModel.initSpecificFolderDataStream(
      _filePickerUseCase
          .getSpecificFolderData(_currentStateModel.getPathForGettingImagesFrom!)
          .listen(
        (data) {
          debugPrint("coming file: ${data?.file}");
          _events.add(SpecificFolderDataStreamHandlerEvent(data));
        },
      ),
    );
  }

  //
  static Stream<TelegramFilePickerStates> _specificFolderDataStreamHandlerEvent(
    SpecificFolderDataStreamHandlerEvent event,
  ) async* {
    if (event.file == null) return;
    final value = TelegramFileImageEntity(
      file: event.file!.file,
      videoPlayerController:
          event.file!.isVideo ? VideoPlayerController.file(event.file!.file) : null,
      videoPreview: event.file!.isVideo
          ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
          : null,
      fileName: event.file!.fileName,
    );
    _currentStateModel.addToFolderDataList(value);
    yield* _emitter();
  }

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
