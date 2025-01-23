import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:yahay/src/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'state_model/telegram_file_picker_state_model.dart';

part 'telegram_file_picker_bloc.freezed.dart';

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
        justEmitStateEvent: (event) => _emitter(emit),
        initAllPicturesEvent: (event) => _initAllPictureEvents(event, emit),
        changeStateToAllPicturesEvent: (event) => _changeStateToAllPicturesEvent(event, emit),
        initAllFilesEvent: (event) => _initAllFilesEvent(event, emit),
        changeStateToAllFilesState: (event) => _changeStateToAllFilesState(event, emit),
        initAllMusicsEvent: (event) => _initAllMusicsEvent(event, emit),
        openHideBottomTelegramButtonEvent: (event) =>
            _openHideBottomTelegramButtonEvent(event, emit),
        closePopupEvent: (event) => _closePopupEvent(event, emit),
        fileStreamHandlerEvent: (event) => _fileStreamHandlerEvent(event, emit),
        recentFileStreamHandlerEvent: (event) => _recentFileStreamHandlerEvent(event, emit),
        imagesAndVideoPaginationEvent: (event) => _imagesAndVideoPaginationEvent(event, emit),
        selectGalleryFileEvent: (event) => _selectGalleryFileEvent(event, emit),
        clearSelectedGalleryFileEvent: (event) => _clearSelectedGalleryFileEvent(event, emit),
        recentFilesPaginationEvent: (event) => _recentFilesPaginationEvent(event, emit),
        browseInternalStorageAndSelectFilesEvent: (event) =>
            _browseInternalStorageAndSelectFilesEvent(event, emit),
        selectScreenForFilesPickerScreenEvent: (event) =>
            _selectScreenForFilesPickerScreenEvent(event, emit),
        setSpecificFolderPathInOrderToGetDataFromThereEvent: (event) =>
            _setSpecificFolderPathInOrderToGetDataFromThereEvent(event, emit),
        getSpecificFolderDataEvent: (event) => _getSpecificFolderDataEvent(event, emit),
        specificFolderDataStreamHandlerEvent: (event) =>
            _specificFolderDataStreamHandlerEvent(event, emit),
        paginateSpecificFolderDataEvent: (event) => _paginateSpecificFolderDataEvent(event, emit),
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

  void _changeStateToAllPicturesEvent(
    _ChangeStateToAllPicturesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    emit(TelegramFilePickerStates.galleryFilePickerState(_currentStateModel));
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

  void _changeStateToAllFilesState(
    _ChangeStateToAllFilesState event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    emit(TelegramFilePickerStates.filesPickerState(
      _currentStateModel,
    ));
  }

  void _initAllMusicsEvent(
    _InitAllMusicsEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {}

  void _openHideBottomTelegramButtonEvent(
    _OpenHideBottomTelegramButtonEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if ((_currentStateModel.openButtonSectionTimer?.isActive ?? false)) {
      _currentStateModel.openButtonSectionTimer?.cancel();
    }
    _currentStateModel.setOpenButtonSectionTimer(Timer(
      const Duration(milliseconds: 350),
      () {
        _currentStateModel.setValueToOpenButtonSectionButton(event.value);
        add(const TelegramFilePickerEvents.justEmitStateEvent());
      },
    ));
  }

  void _closePopupEvent(
    _ClosePopupEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
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
    _currentStateModel.clearAllGalleryPath();
    _currentStateModel.clearAllGalleryPaginationPath();
  }

  void _fileStreamHandlerEvent(
    _FileStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
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
        videoPlayerController: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
            ? VideoPlayerController.file(event.file!.file)
            : null,
        videoPreview: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      // if (model.videoPlayerController == null && model.videoPreview == null) {
      //   if (_currentStateModel.context.mounted) {
      //     // precacheImage(
      //     //   FileImage(event.file!),
      //     //   _currentStateModel.context,
      //     // );
      //   }
      // }

      _currentStateModel.setGalleryPathFiles(model);

      // yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
      //   model,
      //   emitter: _emitter(),
      // );

      // yield* _emitter();

      _emitter(emit);
    }
  }

  void _recentFileStreamHandlerEvent(
    _RecentFileStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.file != null && event.file?.file != null) {
      final model = TelegramFileImageModel(
        file: event.file?.file,
        videoPlayerController: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
            ? VideoPlayerController.file(event.file!.file)
            : null,
        fileName: basename(event.file!.file.path),
        videoPreview: ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
            ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
            : null,
      );

      // if (model.videoPlayerController != null) model.videoPlayerController?.initialize();

      // if (model.videoPlayerController == null && model.videoPreview == null) {
      //   if (_currentStateModel.context.mounted) {
      //     // precacheImage(
      //     //   FileImage(event.file!),
      //     //   _currentStateModel.context,
      //     // );
      //   }
      // }

      _currentStateModel.addToRecentFiles(model);

      _emitter(emit);
    }
  }

  void _imagesAndVideoPaginationEvent(
    _ImagesAndVideoPaginationEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final tempList = ListPaginationChecker.instance.paginateList(
      wholeList: _currentStateModel.galleryPathFiles,
      currentList: _currentStateModel.galleryPathPagination,
    );

    _currentStateModel.addToPagination(tempList);

    _emitter(emit);
  }

  void _selectGalleryFileEvent(
    _SelectGalleryFileEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    _currentStateModel.removeOrAddEntity(event.telegramFileImageEntity);
    _emitter(emit);
  }

  void _clearSelectedGalleryFileEvent(
    _ClearSelectedGalleryFileEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    _currentStateModel.clearPickedFiles();
    _emitter(emit);
  }

  void _recentFilesPaginationEvent(
    _RecentFilesPaginationEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final tempList = ListPaginationChecker.instance.paginateList(
      wholeList: _currentStateModel.recentFiles,
      currentList: _currentStateModel.recentFilesPagination,
    );

    _currentStateModel.addToRecentFilesPagination(tempList);

    _emitter(emit);
  }

  void _browseInternalStorageAndSelectFilesEvent(
    _BrowseInternalStorageAndSelectFilesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final imagePicker = ImagePicker();
    final files = await imagePicker.pickMultipleMedia();
    if (files.isEmpty) return;
    // convert this files into
    final convertedData = files.map((e) => TelegramFileImageModel(file: File(e.path))).toList();
    for (final each in convertedData) {
      _currentStateModel.removeOrAddEntity(each);
    }
    _emitter(emit);
  }

  void _selectScreenForFilesPickerScreenEvent(
    _SelectScreenForFilesPickerScreenEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    _currentStateModel.selectScreen(event.screen);
    _currentStateModel.clearPickedFiles();
    _emitter(emit);
  }

  void _setSpecificFolderPathInOrderToGetDataFromThereEvent(
    _SetSpecificFolderPathInOrderToGetDataFromThereEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.path == null) return;
    _currentStateModel.setPathForGettingImagesFrom(event.path);
    add(const TelegramFilePickerEvents.getSpecificFolderDataEvent(getGalleryData: false));
    _emitter(emit);
  }

  void _getSpecificFolderDataEvent(
    _GetSpecificFolderDataEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (_currentStateModel.getPathForGettingImagesFrom == null && !event.getGalleryData) return;
    _currentStateModel.clearSpecificFolderData();
    _emitter(emit);
    if (event.getGalleryData) {
      _specificFolderData = _telegramFilePickerRepo.getRecentImagesAndVideos().listen(
        (data) {
          debugPrint("path of data: ${data?.file.path}");
          add(TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(data));
        },
      );
    } else {
      _specificFolderData = _telegramFilePickerRepo
          .getSpecificFolderData(_currentStateModel.getPathForGettingImagesFrom!)
          .listen(
        (data) {
          add(TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(data));
        },
      );
    }
  }

  void _specificFolderDataStreamHandlerEvent(
    _SpecificFolderDataStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.file == null) return;
    debugPrint("coming file 2: ${event.file?.file}");

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
    _emitter(emit);
  }

  void _paginateSpecificFolderDataEvent(
    _PaginateSpecificFolderDataEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final data = ListPaginationChecker.instance.paginateList(
      wholeList: _currentStateModel.specificFolderFilesAll,
      currentList: _currentStateModel.specificFolderFilesPagination,
    );

    _currentStateModel.addAllToFolderDataList(data);

    _emitter(emit);
  }

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
