import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
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
    events.add(ClosePopupEvent());
  }

  const TelegramFilePickerBloc._({
    required this.events,
    required BehaviorSubject<TelegramFilePickerStates> states,
  }) : _states = states;

  factory TelegramFilePickerBloc() {
    _filePickerUseCase = FilePickerUseCase();
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
    if (event is InitAllPicturesEvent) {
      yield* _initAllPicturesEvent(event);
    } else if (event is InitAllFilesEvent) {
      yield* _initAllFilesEvent(event);
    } else if (event is InitAllMusicsEvent) {
      yield* _initAllMusicsEvent(event);
    } else if (event is ClosePopupEvent) {
      yield* _closePopupEvent(event);
    } else if (event is FileStreamHandlerEvent) {
      yield* _fileStreamHandlerEvent(event);
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

    try {
      if (_currentStateModel.galleryPathFiles.isEmpty) {
        final TelegramFileImageModel fileModel = TelegramFileImageModel(
          cameraController: CameraController(
            snoopy<CameraHelperService>().cameras.last,
            ResolutionPreset.max,
          ),
        );

        await fileModel.controllerInit();

        _currentStateModel.addOnStreamOfValuesInPaginationList(fileModel);
      } else {
        debugPrint(
            "setting models length: ${_currentStateModel.galleryPathFiles.first.cameraController != null}");
        _currentStateModel.addOnStreamOfValuesInPaginationList(
          _currentStateModel.galleryPathFiles.first,
        );
      }

      _currentStateModel.initFileStreamData(
        _filePickerUseCase.getAllImagesAndVideos().listen(
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
  ) async* {}

  //
  static Stream<TelegramFilePickerStates> _initAllMusicsEvent(
    InitAllMusicsEvent event,
  ) async* {}

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
      );

      if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      _currentStateModel.setGalleryPathFiles(model);

      _currentStateModel.addOnStreamOfValuesInPaginationList(model);

      yield GalleryFilePickerState(_currentStateModel);
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
    _currentStateModel.closeStreamSubs();
    _currentStateModel.clearAllGalleryPath();
    _currentStateModel.clearAllGalleryPaginationPath();
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
