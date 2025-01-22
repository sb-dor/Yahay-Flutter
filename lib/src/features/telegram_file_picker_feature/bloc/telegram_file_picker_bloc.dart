import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'state_model/telegram_file_picker_state_model.dart';

part 'telegram_file_picker_bloc.freezed.dart';

// @immutable
// class TelegramFilePickerBloc {
//   static late FilePickerUseCase _filePickerUseCase;
//
//   //
//   static late TelegramFilePickerStateModel _currentStateModel;
//   static late BehaviorSubject<TelegramFilePickerStates> _currentState; // emitter usage only
//   static late Sink<TelegramFilePickerEvents> _events;
//
//   final Sink<TelegramFilePickerEvents> events;
//   final BehaviorSubject<TelegramFilePickerStates> _states;
//
//   BehaviorSubject<TelegramFilePickerStates> get states => _states;
//
//   static late final CameraHelperService _cameraHelperService;
//
//   void dispose() async {
//     events.add(const ClosePopupEvent());
//     await _states.drain();
//     _states.close();
//     _events.close();
//   }
//
//   const TelegramFilePickerBloc._({
//     required this.events,
//     required BehaviorSubject<TelegramFilePickerStates> states,
//   }) : _states = states;
//
//   factory TelegramFilePickerBloc(
//     final TelegramFilePickerRepo telegramFilePickerRepo,
//     final CameraHelperService cameraHelperService,
//   ) {
//     _cameraHelperService = cameraHelperService;
//
//     _filePickerUseCase = FilePickerUseCase(telegramFilePickerRepo);
//     //
//     _currentStateModel = TelegramFilePickerStateModel();
//
//     final events = BehaviorSubject<TelegramFilePickerEvents>();
//
//     final streamOfEvents = events.switchMap<TelegramFilePickerStates>((events) async* {
//       yield* _streamHandler(events);
//     }).startWith(
//       GalleryFilePickerState(_currentStateModel),
//     );
//
//     final behaviourSubjectFromStream = BehaviorSubject<TelegramFilePickerStates>()
//       ..addStream(streamOfEvents);
//
//     _currentState = behaviourSubjectFromStream;
//
//     _events = events;
//
//     return TelegramFilePickerBloc._(
//       events: events.sink,
//       states: behaviourSubjectFromStream,
//     );
//   }
//
//   static Stream<TelegramFilePickerStates> _streamHandler(
//     TelegramFilePickerEvents event,
//   ) async* {
//     if (event is JustEmitStateEvent) {
//       yield* _emitter();
//     } else if (event is InitAllPicturesEvent) {
//       yield* _initAllPicturesEvent(event);
//     } else if (event is ChangeStateToAllPicturesEvent) {
//       yield GalleryFilePickerState(_currentStateModel);
//     } else if (event is InitAllFilesEvent) {
//       yield* _initAllFilesEvent(event);
//     } else if (event is ChangeStateToAllFilesState) {
//       yield FilesPickerState(_currentStateModel);
//     } else if (event is InitAllMusicsEvent) {
//       yield* _initAllMusicsEvent(event);
//     } else if (event is ClosePopupEvent) {
//       yield* _closePopupEvent(event);
//     } else if (event is OpenHideBottomTelegramButtonEvent) {
//       yield* _openHideBottomTelegramButtonEvent(event);
//     } else if (event is FileStreamHandlerEvent) {
//       yield* _fileStreamHandlerEvent(event);
//     } else if (event is RecentFileStreamHandlerEvent) {
//       yield* _recentFileStreamHandlerEvent(event);
//     } else if (event is ImagesAndVideoPaginationEvent) {
//       yield* _imagesAndVideoPaginationEvent();
//     } else if (event is RecentFilesPaginationEvent) {
//       yield* _recentFilesPaginationEvent(event);
//     } else if (event is SelectGalleryFileEvent) {
//       yield* _selectGalleryFileEvent(event);
//     } else if (event is ClearSelectedGalleryFileEvent) {
//       yield* _clearSelectedGalleryFileEvent(event);
//     } else if (event is BrowseInternalStorageAndSelectFilesEvent) {
//       yield* _browseInternalStorageAndSelectFilesEvent(event);
//     } else if (event is SelectScreenForFilesPickerScreenEvent) {
//       yield* _selectScreenForFilesPickerScreenEvent(event);
//     } else if (event is GetSpecificFolderDataEvent) {
//       yield* _getSpecificFolderDataEvent(event);
//     } else if (event is SpecificFolderDataStreamHandlerEvent) {
//       yield* _specificFolderDataStreamHandlerEvent(event);
//     } else if (event is SetSpecificFolderPathInOrderToGetDataFromThereEvent) {
//       yield* _setSpecificFolderPathInOrderToGetDataFromThereEvent(event);
//     } else if (event is PaginateSpecificFolderDataEvent) {
//       yield* _paginateSpecificFolderDataEvent(event);
//     }
//   }
//
//   static Stream<TelegramFilePickerStates> _initAllPicturesEvent(
//     InitAllPicturesEvent event,
//   ) async* {
//     if (event.controller != null) {
//       _currentStateModel.initDragScrollController(event.controller!);
//     }
//     _currentStateModel.clearAllGalleryPath(clearAll: false);
//     _currentStateModel.clearAllGalleryPaginationPath(clearAll: false);
//     _currentStateModel.clearPickedFiles();
//
//     try {
//       if (_currentStateModel.galleryPathFiles.isEmpty) {
//         final TelegramFileImageModel fileModel = TelegramFileImageModel(
//           cameraController: CameraController(
//             _cameraHelperService.cameras.last,
//             ResolutionPreset.max,
//           ),
//         );
//
//         // this init shows getting permission from uses for recording video or taking pictures from camera
//         await fileModel.controllerInit();
//
//         yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
//           fileModel,
//           emitter: _emitter(),
//         );
//       } else {
//         yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
//           _currentStateModel.galleryPathFiles.first,
//           emitter: _emitter(),
//         );
//       }
//
//       _currentStateModel.initFileStreamData(
//         _filePickerUseCase.getRecentImagesAndVideos().listen(
//           (value) {
//             _events.add(FileStreamHandlerEvent(value));
//           },
//         )..onDone(() {
//             //
//             debugPrint("im done!");
//           }),
//       );
//
//       _events.add(const InitAllFilesEvent(initFilePickerState: false));
//
//       yield GalleryFilePickerState(_currentStateModel);
//     } catch (e) {
//       debugPrint("ini all pictures event is: $e");
//     }
//   }
//
//   //
//
//   static Stream<TelegramFilePickerStates> _initAllFilesEvent(
//     InitAllFilesEvent event,
//   ) async* {

//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _initAllMusicsEvent(
//     InitAllMusicsEvent event,
//   ) async* {}
//
//   static Stream<TelegramFilePickerStates> _openHideBottomTelegramButtonEvent(
//     OpenHideBottomTelegramButtonEvent event,
//   ) async* {
//     if ((_currentStateModel.openButtonSectionTimer?.isActive ?? false)) {
//       _currentStateModel.openButtonSectionTimer?.cancel();
//     }
//     _currentStateModel.setOpenButtonSectionTimer(Timer(
//       const Duration(milliseconds: 350),
//       () {
//         _currentStateModel.setValueToOpenButtonSectionButton(event.value);
//         _events.add(const JustEmitStateEvent());
//       },
//     ));
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _fileStreamHandlerEvent(
//     FileStreamHandlerEvent event,
//   ) async* {
//     if (event.file != null && event.file?.file != null) {
//       // it's not paginating logic
//       // that is why this function should get stream of file
//       // any time when it comes and
//       // put it inside whole list
//       // and should check the pagination list until specific length
//       // and keep pushing that file inside that pagination list
//       // until list reaches specific length of pagination
//       final model = TelegramFileImageModel(
//         file: event.file!.file,
//         videoPlayerController: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
//             ? VideoPlayerController.file(event.file!.file)
//             : null,
//         videoPreview: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
//             ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
//             : null,
//       );
//
//       // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();
//
//       // if (model.videoPlayerController == null && model.videoPreview == null) {
//       //   if (_currentStateModel.context.mounted) {
//       //     // precacheImage(
//       //     //   FileImage(event.file!),
//       //     //   _currentStateModel.context,
//       //     // );
//       //   }
//       // }
//
//       _currentStateModel.setGalleryPathFiles(model);
//
//       yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
//         model,
//         emitter: _emitter(),
//       );
//
//       // yield* _emitter();
//     }
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _recentFileStreamHandlerEvent(
//     RecentFileStreamHandlerEvent event,
//   ) async* {
//     if (event.file != null && event.file?.file != null) {
//       final model = TelegramFileImageModel(
//         file: event.file?.file,
//         videoPlayerController: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
//             ? VideoPlayerController.file(event.file!.file)
//             : null,
//         fileName: basename(event.file!.file.path),
//         videoPreview: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
//             ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
//             : null,
//       );
//
//       // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();
//
//       // if (model.videoPlayerController == null && model.videoPreview == null) {
//       //   if (_currentStateModel.context.mounted) {
//       //     // precacheImage(
//       //     //   FileImage(event.file!),
//       //     //   _currentStateModel.context,
//       //     // );
//       //   }
//       // }
//
//       _currentStateModel.addToRecentFiles(model);
//
//       yield* _emitter();
//     }
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _imagesAndVideoPaginationEvent() async* {
//     final tempList = ListPaginationChecker.instance.paginateList(
//       wholeList: _currentStateModel.galleryPathFiles,
//       currentList: _currentStateModel.galleryPathPagination,
//     );
//
//     _currentStateModel.addToPagination(tempList);
//
//     yield* _emitter();
//   }
//
//   static Stream<TelegramFilePickerStates> _clearSelectedGalleryFileEvent(
//     ClearSelectedGalleryFileEvent event,
//   ) async* {
//     _currentStateModel.clearPickedFiles();
//     yield* _emitter();
//   }
//
//   static Stream<TelegramFilePickerStates> _selectGalleryFileEvent(
//     SelectGalleryFileEvent event,
//   ) async* {
//     _currentStateModel.removeOrAddEntity(event.telegramFileImageEntity);
//     yield* _emitter();
//   }
//
//   static Stream<TelegramFilePickerStates> _recentFilesPaginationEvent(
//     RecentFilesPaginationEvent event,
//   ) async* {
//     final tempList = ListPaginationChecker.instance.paginateList(
//       wholeList: _currentStateModel.recentFiles,
//       currentList: _currentStateModel.recentFilesPagination,
//     );
//
//     _currentStateModel.addToRecentFilesPagination(tempList);
//
//     yield* _emitter();
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _closePopupEvent(
//     ClosePopupEvent event,
//   ) async* {
//     // await DefaultCacheManager().emptyCache();
//     if (_currentStateModel.galleryPathFiles.firstOrNull?.cameraController != null) {
//       _currentStateModel.galleryPathFiles.firstOrNull?.cameraController?.dispose();
//     }
//     for (final each in _currentStateModel.galleryPathFiles) {
//       each.videoPlayerController?.dispose();
//     }
//     if (_currentStateModel.galleryPathPagination.firstOrNull?.cameraController != null) {
//       _currentStateModel.galleryPathPagination.firstOrNull?.cameraController?.dispose();
//     }
//     for (final each in _currentStateModel.galleryPathPagination) {
//       each.videoPlayerController?.dispose();
//     }
//     _currentStateModel.closeAllStreamSubs();
//     _currentStateModel.clearAllGalleryPath();
//     _currentStateModel.clearAllGalleryPaginationPath();
//   }
//
//   //
//   void resetDragScrollSheet() {
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _currentStateModel.draggableScrollableController?.animateTo(
//         0.5,
//         duration: const Duration(seconds: 1),
//         curve: Curves.fastOutSlowIn,
//       );
//     });
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _browseInternalStorageAndSelectFilesEvent(
//     BrowseInternalStorageAndSelectFilesEvent event,
//   ) async* {
//     final imagePicker = ImagePicker();
//     final files = await imagePicker.pickMultipleMedia();
//     if (files.isEmpty) return;
//     // convert this files into
//     final convertedData = files.map((e) => TelegramFileImageModel(file: File(e.path))).toList();
//     for (final each in convertedData) {
//       _currentStateModel.removeOrAddEntity(each);
//     }
//     yield* _emitter();
//   }
//
//   static Stream<TelegramFilePickerStates> _selectScreenForFilesPickerScreenEvent(
//     SelectScreenForFilesPickerScreenEvent event,
//   ) async* {
//     _currentStateModel.selectScreen(event.screen);
//     _currentStateModel.clearPickedFiles();
//     yield* _emitter();
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _setSpecificFolderPathInOrderToGetDataFromThereEvent(
//     SetSpecificFolderPathInOrderToGetDataFromThereEvent event,
//   ) async* {
//     if (event.path == null) return;
//     _currentStateModel.setPathForGettingImagesFrom(event.path);
//     _events.add(const GetSpecificFolderDataEvent());
//     yield* _emitter();
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _getSpecificFolderDataEvent(
//     GetSpecificFolderDataEvent event,
//   ) async* {
//     if (_currentStateModel.getPathForGettingImagesFrom == null && !event.getGalleryData) return;
//     _currentStateModel.clearSpecificFolderData();
//     _currentStateModel.closeSpecificFolderDataStream();
//     yield* _emitter();
//     if (event.getGalleryData) {
//       _currentStateModel.initSpecificFolderDataStream(
//         _filePickerUseCase.getRecentImagesAndVideos().listen(
//           (data) {
//             debugPrint("path of data: ${data?.file.path}");
//             _events.add(SpecificFolderDataStreamHandlerEvent(data));
//           },
//         ),
//       );
//     } else {
//       _currentStateModel.initSpecificFolderDataStream(
//         _filePickerUseCase
//             .getSpecificFolderData(_currentStateModel.getPathForGettingImagesFrom!)
//             .listen(
//           (data) {
//             _events.add(SpecificFolderDataStreamHandlerEvent(data));
//           },
//         ),
//       );
//     }
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _specificFolderDataStreamHandlerEvent(
//     SpecificFolderDataStreamHandlerEvent event,
//   ) async* {
//     if (event.file == null) return;
//     debugPrint("coming file 2: ${event.file?.file}");
//
//     final value = TelegramFileImageEntity(
//       file: event.file!.file,
//       videoPlayerController:
//           event.file!.isVideo ? VideoPlayerController.file(event.file!.file) : null,
//       videoPreview: event.file!.isVideo
//           ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
//           : null,
//       fileName: event.file!.fileName,
//     );
//     _currentStateModel.addToFolderDataList(value);
//     yield* _emitter();
//   }
//
//   //
//   static Stream<TelegramFilePickerStates> _paginateSpecificFolderDataEvent(
//     PaginateSpecificFolderDataEvent event,
//   ) async* {
//     final data = ListPaginationChecker.instance.paginateList(
//       wholeList: _currentStateModel.specificFolderFilesAll,
//       currentList: _currentStateModel.specificFolderFilesPagination,
//     );
//
//     _currentStateModel.addAllToFolderDataList(data);
//
//     yield* _emitter();
//   }
//
//   //
//   // emitter
//   static Stream<TelegramFilePickerStates> _emitter() async* {
//     if (_currentState.value is GalleryFilePickerState) {
//       yield GalleryFilePickerState(_currentStateModel);
//     } else if (_currentState.value is FilesPickerState) {
//       yield FilesPickerState(_currentStateModel);
//     } else if (_currentState.value is MusicFilesPickerState) {
//       yield MusicFilesPickerState(_currentStateModel);
//     }
//   }
// }

@immutable
@freezed
class TelegramFilePickerEvents with _$TelegramFilePickerEvents {
  const factory TelegramFilePickerEvents.justEmitStateEvent() = _JustEmitStateEvent;

  const factory TelegramFilePickerEvents.initAllPicturesEvent(
    final bool clearAll, {
    final DraggableScrollableController? controller,
  }) = _InitAllPicturesEvent;

  const factory TelegramFilePickerEvents.changeStateToAllPicturesEvent() =
      _ChangeStateToAllPicturesEvent;

  const factory TelegramFilePickerEvents.initAllFilesEvent({
    required final bool initFilePickerState,
  }) = _InitAllFilesEvent;

  const factory TelegramFilePickerEvents.changeStateToAllFilesState() = _ChangeStateToAllFilesState;

  const factory TelegramFilePickerEvents.initAllMusicsEvent() = _InitAllMusicsEvent;

  const factory TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(final bool value) =
      _OpenHideBottomTelegramButtonEvent;

  const factory TelegramFilePickerEvents.closePopupEvent() = _ClosePopupEvent;

  const factory TelegramFilePickerEvents.fileStreamHandlerEvent(
      final TelegramPathFolderFile? file) = _FileStreamHandlerEvent;

  const factory TelegramFilePickerEvents.recentFileStreamHandlerEvent(
      final TelegramPathFolderFile? file) = _RecentFileStreamHandlerEvent;

  const factory TelegramFilePickerEvents.imagesAndVideoPaginationEvent() =
      _ImagesAndVideoPaginationEvent;

  const factory TelegramFilePickerEvents.selectGalleryFileEvent(
      final TelegramFileImageEntity? telegramFileImageEntity) = _SelectGalleryFileEvent;

  const factory TelegramFilePickerEvents.clearSelectedGalleryFileEvent() =
      _ClearSelectedGalleryFileEvent;

  const factory TelegramFilePickerEvents.recentFilesPaginationEvent() = _RecentFilesPaginationEvent;

  const factory TelegramFilePickerEvents.browseInternalStorageAndSelectFilesEvent() =
      _BrowseInternalStorageAndSelectFilesEvent;

  const factory TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
      final TelegramFileFolderEnum screen) = _SelectScreenForFilesPickerScreenEvent;

  const factory TelegramFilePickerEvents.setSpecificFolderPathInOrderToGetDataFromThereEvent(
      final String? path) = _SetSpecificFolderPathInOrderToGetDataFromThereEvent;

  const factory TelegramFilePickerEvents.getSpecificFolderDataEvent(
      {required final bool getGalleryData}) = _GetSpecificFolderDataEvent;

  const factory TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(
      final TelegramPathFolderFile? file) = _SpecificFolderDataStreamHandlerEvent;

  const factory TelegramFilePickerEvents.paginateSpecificFolderDataEvent() =
      _PaginateSpecificFolderDataEvent;
}

//
@immutable
@freezed
sealed class TelegramFilePickerStates with _$TelegramFilePickerStates {
  const factory TelegramFilePickerStates.initial(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = InitialPickerState;

  const factory TelegramFilePickerStates.galleryFilePickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = GalleryFilePickerState;

  const factory TelegramFilePickerStates.filesPickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = FilesPickerState;

  const factory TelegramFilePickerStates.musicFilesPickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = MusicFilesPickerState;
}

class TelegramFilePickerBloc extends Bloc<TelegramFilePickerEvents, TelegramFilePickerStates> {
  //

  StreamSubscription<TelegramPathFolderFile?>? _fileStreamData;

  StreamSubscription<TelegramPathFolderFile?>? _recentFileData;

  StreamSubscription<TelegramPathFolderFile?>? _specificFolderData;

  //
  final TelegramFilePickerRepo _telegramFilePickerRepo;
  final CameraHelperService _cameraHelperService;
  late final TelegramFilePickerStateModel _currentStateModel;

  TelegramFilePickerBloc({
    required final TelegramFilePickerRepo telegramFilePickerRepo,
    required final CameraHelperService cameraHelperService,
    required final TelegramFilePickerStates initialState,
  })  : _telegramFilePickerRepo = telegramFilePickerRepo,
        _cameraHelperService = cameraHelperService,
        super(initialState) {
    _currentStateModel = initialState.telegramFilePickerStateModel;

    on<TelegramFilePickerEvents>(
      (event, emit) => event.map(
        justEmitStateEvent: justEmitStateEvent,
        initAllPicturesEvent: (event) => _initAllPictureEvents(event, emit),
        changeStateToAllPicturesEvent: (event) => emit(
          TelegramFilePickerStates.galleryFilePickerState(
            _currentStateModel,
          ),
        ),
        initAllFilesEvent: (event) => _initAllFilesEvent(event, emit),
        changeStateToAllFilesState: (event) => emit(
          TelegramFilePickerStates.filesPickerState(
            _currentStateModel,
          ),
        ),
        initAllMusicsEvent: (event) => _initAllMusicsEvent(event, emit),
        openHideBottomTelegramButtonEvent: openHideBottomTelegramButtonEvent,
        closePopupEvent: closePopupEvent,
        fileStreamHandlerEvent: fileStreamHandlerEvent,
        recentFileStreamHandlerEvent: recentFileStreamHandlerEvent,
        imagesAndVideoPaginationEvent: imagesAndVideoPaginationEvent,
        selectGalleryFileEvent: selectGalleryFileEvent,
        clearSelectedGalleryFileEvent: clearSelectedGalleryFileEvent,
        recentFilesPaginationEvent: recentFilesPaginationEvent,
        browseInternalStorageAndSelectFilesEvent: browseInternalStorageAndSelectFilesEvent,
        selectScreenForFilesPickerScreenEvent: selectScreenForFilesPickerScreenEvent,
        setSpecificFolderPathInOrderToGetDataFromThereEvent:
            setSpecificFolderPathInOrderToGetDataFromThereEvent,
        getSpecificFolderDataEvent: getSpecificFolderDataEvent,
        specificFolderDataStreamHandlerEvent: specificFolderDataStreamHandlerEvent,
        paginateSpecificFolderDataEvent: paginateSpecificFolderDataEvent,
      ),
    );
  }

  void _initAllPictureEvents(
    _InitAllPicturesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.controller != null) {
      _currentStateModel.initDragScrollController(event.controller!);
    }
    _currentStateModel.clearAllGalleryPath(clearAll: false);
    _currentStateModel.clearAllGalleryPaginationPath(clearAll: false);
    _currentStateModel.clearPickedFiles();

    try {
      if (_currentStateModel.galleryPathFiles.isEmpty) {
        final TelegramFileImageModel fileModel = TelegramFileImageModel(
          cameraController: CameraController(
            _cameraHelperService.cameras.last,
            ResolutionPreset.max,
          ),
        );

        // this init shows getting permission from uses for recording video or taking pictures from camera
        await fileModel.controllerInit();

        _currentStateModel.addOnStreamOfValuesInPaginationList(
          fileModel,
        );
      } else {
        _currentStateModel.addOnStreamOfValuesInPaginationList(
          _currentStateModel.galleryPathFiles.first,
        );
      }

      _fileStreamData = _telegramFilePickerRepo.getRecentImagesAndVideos().listen(
        (value) {
          add(TelegramFilePickerEvents.fileStreamHandlerEvent(value));
        },
      )..onDone(() {
          //
          debugPrint("im done!");
        });

      add(const TelegramFilePickerEvents.initAllFilesEvent(initFilePickerState: false));

      emit(TelegramFilePickerStates.galleryFilePickerState(_currentStateModel));
    } catch (e) {
      debugPrint("ini all pictures event is: $e");
    }
  }

  void _initAllFilesEvent(
    _InitAllFilesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    _currentStateModel.clearRecentFiles();
    _currentStateModel.clearRecentPagFiles();
    _recentFileData = _telegramFilePickerRepo.getRecentFiles().listen((e) {
      add(TelegramFilePickerEvents.recentFileStreamHandlerEvent(e));
    });

    if (event.initFilePickerState) {
      emit(TelegramFilePickerStates.filesPickerState(_currentStateModel));
    } else {
      _emitter(emit);
    }
  }

  void _initAllMusicsEvent(
    _InitAllMusicsEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {}

  void resetDragScrollSheet() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _currentStateModel.draggableScrollableController?.animateTo(
        0.5,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void _emitter(Emitter<TelegramFilePickerStates> emit) async {
    switch (state) {
      case InitialPickerState():
        emit(TelegramFilePickerStates.initial(_currentStateModel));
        break;
      case GalleryFilePickerState():
        emit(TelegramFilePickerStates.galleryFilePickerState(_currentStateModel));
        break;
      case FilesPickerState():
        emit(TelegramFilePickerStates.filesPickerState(_currentStateModel));
        break;
      case MusicFilesPickerState():
        emit(TelegramFilePickerStates.musicFilesPickerState(_currentStateModel));
        break;
    }
  }

  @override
  Future<void> close() async {
    await _fileStreamData?.cancel();
    await _recentFileData?.cancel();
    await _specificFolderData?.cancel();
    return super.close();
  }
}
