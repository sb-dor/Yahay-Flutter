import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
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
sealed class TelegramFilePickerEvents with _$TelegramFilePickerEvents {
  const factory TelegramFilePickerEvents.justEmitStateEvent(
    final TelegramFilePickerStateModel currentStateModel,
  ) = _JustEmitStateEvent;

  const factory TelegramFilePickerEvents.initAllPicturesEvent(final bool clearAll) =
      _InitAllPicturesEvent;

  const factory TelegramFilePickerEvents.changeStateToAllPicturesEvent() =
      _ChangeStateToAllPicturesEvent;

  const factory TelegramFilePickerEvents.initAllFilesEvent({
    required final bool initFilePickerState,
  }) = _InitAllFilesEvent;

  const factory TelegramFilePickerEvents.changeStateToAllFilesState() = _ChangeStateToAllFilesState;

  const factory TelegramFilePickerEvents.initAllAudioEvent() = _InitAllAudioEvent;

  const factory TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(final bool value) =
      _OpenHideBottomTelegramButtonEvent;

  const factory TelegramFilePickerEvents.closePopupEvent() = _ClosePopupEvent;

  const factory TelegramFilePickerEvents.fileStreamHandlerEvent(
    final TelegramPathFolderFile? file,
  ) = _FileStreamHandlerEvent;

  const factory TelegramFilePickerEvents.recentFileStreamHandlerEvent(
    final TelegramPathFolderFile? file,
  ) = _RecentFileStreamHandlerEvent;

  const factory TelegramFilePickerEvents.imagesAndVideoPaginationEvent() =
      _ImagesAndVideoPaginationEvent;

  const factory TelegramFilePickerEvents.selectGalleryFileEvent(
    final TelegramFileImageEntity? telegramFileImageEntity,
  ) = _SelectGalleryFileEvent;

  const factory TelegramFilePickerEvents.clearSelectedGalleryFileEvent() =
      _ClearSelectedGalleryFileEvent;

  const factory TelegramFilePickerEvents.recentFilesPaginationEvent() = _RecentFilesPaginationEvent;

  const factory TelegramFilePickerEvents.browseInternalStorageAndSelectFilesEvent() =
      _BrowseInternalStorageAndSelectFilesEvent;

  const factory TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
    final TelegramFileFolderEnum screen,
  ) = _SelectScreenForFilesPickerScreenEvent;

  const factory TelegramFilePickerEvents.setSpecificFolderPathInOrderToGetDataFromThereEvent(
    final String? path,
  ) = _SetSpecificFolderPathInOrderToGetDataFromThereEvent;

  const factory TelegramFilePickerEvents.getSpecificFolderDataEvent({
    required final bool getGalleryData,
  }) = _GetSpecificFolderDataEvent;

  const factory TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(
    final TelegramPathFolderFile? file,
  ) = _SpecificFolderDataStreamHandlerEvent;

  const factory TelegramFilePickerEvents.paginateSpecificFolderDataEvent() =
      _PaginateSpecificFolderDataEvent;
}

//
@immutable
@freezed
sealed class TelegramFilePickerStates with _$TelegramFilePickerStates {
  const factory TelegramFilePickerStates.initial(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = Picker$InitialState;

  const factory TelegramFilePickerStates.galleryFilePickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = Picker$GalleryFileState;

  const factory TelegramFilePickerStates.filesPickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = Picker$FilesState;

  const factory TelegramFilePickerStates.audioFilesPickerState(
    final TelegramFilePickerStateModel telegramFilePickerStateModel,
  ) = Picker$AudioFilesState;
}

class TelegramFilePickerBloc extends Bloc<TelegramFilePickerEvents, TelegramFilePickerStates> {
  //

  StreamSubscription<TelegramPathFolderFile?>? _fileStreamData;

  StreamSubscription<TelegramPathFolderFile?>? _recentFileData;

  StreamSubscription<TelegramPathFolderFile?>? _specificFolderData;

  Timer? _openButtonSectionTimer;

  //
  final TelegramFilePickerRepo _telegramFilePickerRepo;
  final CameraHelperService _cameraHelperService;

  TelegramFilePickerBloc({
    required final TelegramFilePickerRepo telegramFilePickerRepo,
    required final CameraHelperService cameraHelperService,
    required final TelegramFilePickerStates initialState,
  }) : _telegramFilePickerRepo = telegramFilePickerRepo,
       _cameraHelperService = cameraHelperService,
       super(initialState) {
    on<TelegramFilePickerEvents>(
      (event, emit) => event.map(
        justEmitStateEvent:
            (event) => _emitter(currentStateModel: event.currentStateModel, emit: emit),
        initAllPicturesEvent: (event) => _initAllPictureEvents(event, emit),
        changeStateToAllPicturesEvent: (event) => _changeStateToAllPicturesEvent(event, emit),
        initAllFilesEvent: (event) => _initAllFilesEvent(event, emit),
        changeStateToAllFilesState: (event) => _changeStateToAllFilesState(event, emit),
        initAllAudioEvent: (event) => _initAllAudioEvent(event, emit),
        openHideBottomTelegramButtonEvent:
            (event) => _openHideBottomTelegramButtonEvent(event, emit),
        closePopupEvent: (event) => _closePopupEvent(event, emit),
        fileStreamHandlerEvent: (event) => _fileStreamHandlerEvent(event, emit),
        recentFileStreamHandlerEvent: (event) => _recentFileStreamHandlerEvent(event, emit),
        imagesAndVideoPaginationEvent: (event) => _imagesAndVideoPaginationEvent(event, emit),
        selectGalleryFileEvent: (event) => _selectGalleryFileEvent(event, emit),
        clearSelectedGalleryFileEvent: (event) => _clearSelectedGalleryFileEvent(event, emit),
        recentFilesPaginationEvent: (event) => _recentFilesPaginationEvent(event, emit),
        browseInternalStorageAndSelectFilesEvent:
            (event) => _browseInternalStorageAndSelectFilesEvent(event, emit),
        selectScreenForFilesPickerScreenEvent:
            (event) => _selectScreenForFilesPickerScreenEvent(event, emit),
        setSpecificFolderPathInOrderToGetDataFromThereEvent:
            (event) => _setSpecificFolderPathInOrderToGetDataFromThereEvent(event, emit),
        getSpecificFolderDataEvent: (event) => _getSpecificFolderDataEvent(event, emit),
        specificFolderDataStreamHandlerEvent:
            (event) => _specificFolderDataStreamHandlerEvent(event, emit),
        paginateSpecificFolderDataEvent: (event) => _paginateSpecificFolderDataEvent(event, emit),
      ),
    );
  }

  void _initAllPictureEvents(
    _InitAllPicturesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    // _currentStateModel.clearAllGalleryPath(clearAll: false);
    // _currentStateModel.clearAllGalleryPaginationPath(clearAll: false);
    // _currentStateModel.clearPickedFiles();

    var currentStateModel = state.telegramFilePickerStateModel.copyWith();

    try {
      if (currentStateModel.galleryPathFiles.isEmpty) {
        final TelegramFileImageModel fileModel = TelegramFileImageModel(
          cameraController: CameraController(
            _cameraHelperService.cameras.last,
            ResolutionPreset.max,
          ),
        );

        // this init shows getting permission from uses for recording video or taking pictures from camera
        await fileModel.controllerInit();

        currentStateModel = addOnStreamOfValuesInPaginationList(fileModel);
      } else {
        currentStateModel = addOnStreamOfValuesInPaginationList(
          state.telegramFilePickerStateModel.galleryPathFiles.first,
        );
      }

      _fileStreamData = _telegramFilePickerRepo.getRecentImagesAndVideos().listen((value) {
        debugPrint("any other image coming here brother: $value");
        add(TelegramFilePickerEvents.fileStreamHandlerEvent(value));
      })..onDone(() {
        //
        debugPrint("im done!");
      });

      add(const TelegramFilePickerEvents.initAllFilesEvent(initFilePickerState: false));

      emit(TelegramFilePickerStates.galleryFilePickerState(currentStateModel));
    } catch (error, stackTrace) {
      debugPrint("ini all pictures event is: $error");
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _changeStateToAllPicturesEvent(
    _ChangeStateToAllPicturesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    emit(TelegramFilePickerStates.galleryFilePickerState(state.telegramFilePickerStateModel));
  }

  void _initAllFilesEvent(_InitAllFilesEvent event, Emitter<TelegramFilePickerStates> emit) async {
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      recentFiles: <TelegramFileImageEntity>[],
      recentFilesPagination: <TelegramFileImageEntity>[],
    );
    // _currentStateModel.clearRecentFiles();
    // _currentStateModel.clearRecentPagFiles();
    _recentFileData = _telegramFilePickerRepo.getRecentFiles().listen((e) {
      debugPrint("coming inside recent file: $e");
      add(TelegramFilePickerEvents.recentFileStreamHandlerEvent(e));
    });

    if (event.initFilePickerState) {
      emit(TelegramFilePickerStates.filesPickerState(currentStateModel));
    } else {
      _emitter(currentStateModel: currentStateModel, emit: emit);
    }
  }

  void _changeStateToAllFilesState(
    _ChangeStateToAllFilesState event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    emit(TelegramFilePickerStates.filesPickerState(state.telegramFilePickerStateModel));
  }

  void _initAllAudioEvent(_InitAllAudioEvent event, Emitter<TelegramFilePickerStates> emit) async {}

  void _openHideBottomTelegramButtonEvent(
    _OpenHideBottomTelegramButtonEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if ((_openButtonSectionTimer?.isActive ?? false)) {
      _openButtonSectionTimer?.cancel();
    }
    _openButtonSectionTimer = Timer(const Duration(milliseconds: 350), () {
      final currentStateModel = state.telegramFilePickerStateModel.copyWith(
        openBottomSectionButton: event.value,
      );
      add(TelegramFilePickerEvents.justEmitStateEvent(currentStateModel));
    });
  }

  void _closePopupEvent(_ClosePopupEvent event, Emitter<TelegramFilePickerStates> emit) async {
    // await DefaultCacheManager().emptyCache();
    if (state.telegramFilePickerStateModel.galleryPathFiles.firstOrNull?.cameraController != null) {
      state.telegramFilePickerStateModel.galleryPathFiles.firstOrNull?.cameraController?.dispose();
    }
    for (final each in state.telegramFilePickerStateModel.galleryPathFiles) {
      each.videoPlayerController?.dispose();
    }
    if (state.telegramFilePickerStateModel.galleryPathPagination.firstOrNull?.cameraController !=
        null) {
      state.telegramFilePickerStateModel.galleryPathPagination.firstOrNull?.cameraController
          ?.dispose();
    }
    for (final each in state.telegramFilePickerStateModel.galleryPathPagination) {
      each.videoPlayerController?.dispose();
    }
    // state.telegramFilePickerStateModel.clearAllGalleryPath();
    // state.telegramFilePickerStateModel.clearAllGalleryPaginationPath();
  }

  void _fileStreamHandlerEvent(
    _FileStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.file != null && event.file?.file != null) {
      debugPrint("diving inside me brother: ${event.file?.file}");
      // it's not paginating logic
      // that is why this function should get stream of file
      // any time when it comes and
      // put it inside whole list
      // and should check the pagination list until specific length
      // and keep pushing that file inside that pagination list
      // until list reaches specific length of pagination
      final model = TelegramFileImageModel(
        file: event.file!.file,
        videoPlayerController:
            ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
                ? VideoPlayerController.file(event.file!.file)
                : null,
        videoPreview:
            ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
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

      final galleryPathFiles = List.of(state.telegramFilePickerStateModel.galleryPathFiles);

      galleryPathFiles.add(model);

      var currentStateModel = state.telegramFilePickerStateModel.copyWith(
        galleryPathFiles: galleryPathFiles,
      );

      currentStateModel = addOnStreamOfValuesInPaginationList(model);
      // yield* _currentStateModel.addOnStreamOfValuesInPaginationList(
      //   model,
      //   emitter: _emitter(),
      // );

      // yield* _emitter();

      _emitter(currentStateModel: currentStateModel, emit: emit);
    }
  }

  void _recentFileStreamHandlerEvent(
    _RecentFileStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.file != null && event.file?.file != null) {
      final model = TelegramFileImageModel(
        file: event.file?.file,
        videoPlayerController:
            ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
                ? VideoPlayerController.file(event.file!.file)
                : null,
        fileName: basename(event.file!.file.path),
        videoPreview:
            ReusableGlobalFunctions.instance.isVideoFile(event.file!.file.path)
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

      final currentStateModel = addToRecentFiles(
        currentStateModel: state.telegramFilePickerStateModel,
        value: model,
      );

      _emitter(currentStateModel: currentStateModel, emit: emit);
    }
  }

  void _imagesAndVideoPaginationEvent(
    _ImagesAndVideoPaginationEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final tempList = ListPaginationChecker.instance.paginateList(
      wholeList: state.telegramFilePickerStateModel.galleryPathFiles,
      currentList: state.telegramFilePickerStateModel.galleryPathPagination,
    );

    // _currentStateModel.addToPagination();

    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      galleryPathPagination: [
        ...state.telegramFilePickerStateModel.galleryPathPagination,
        ...tempList,
      ],
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _selectGalleryFileEvent(
    _SelectGalleryFileEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final currentStateModel = _removeOrAddEntity(
      currentStateModel: state.telegramFilePickerStateModel,
      value: event.telegramFileImageEntity,
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _clearSelectedGalleryFileEvent(
    _ClearSelectedGalleryFileEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      pickedFiles: <TelegramFileImageEntity>[],
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _recentFilesPaginationEvent(
    _RecentFilesPaginationEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final tempList = ListPaginationChecker.instance.paginateList(
      wholeList: state.telegramFilePickerStateModel.recentFiles,
      currentList: state.telegramFilePickerStateModel.recentFilesPagination,
    );

    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      recentFilesPagination: [
        ...state.telegramFilePickerStateModel.recentFilesPagination,
        ...tempList,
      ],
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _browseInternalStorageAndSelectFilesEvent(
    _BrowseInternalStorageAndSelectFilesEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final imagePicker = ImagePicker();
    final files = await imagePicker.pickMultipleMedia();
    if (files.isEmpty) return;
    var currentStateModel = state.telegramFilePickerStateModel;
    // convert this files into
    final convertedData = files.map((e) => TelegramFileImageModel(file: File(e.path))).toList();
    for (final each in convertedData) {
      currentStateModel = _removeOrAddEntity(currentStateModel: currentStateModel, value: each);
    }

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _selectScreenForFilesPickerScreenEvent(
    _SelectScreenForFilesPickerScreenEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      filePickerScreenSelectedScreen: event.screen,
      pickedFiles: <TelegramFileImageEntity>[],
    );
    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _setSpecificFolderPathInOrderToGetDataFromThereEvent(
    _SetSpecificFolderPathInOrderToGetDataFromThereEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.path == null) return;
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      getPathForGettingImagesFrom: event.path,
    );

    add(const TelegramFilePickerEvents.getSpecificFolderDataEvent(getGalleryData: false));

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _getSpecificFolderDataEvent(
    _GetSpecificFolderDataEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (state.telegramFilePickerStateModel.getPathForGettingImagesFrom == null &&
        !event.getGalleryData) {
      return;
    }
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      specificFolderFilesAll: <TelegramFileImageEntity>[],
      specificFolderFilesPagination: <TelegramFileImageEntity>[],
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);

    if (event.getGalleryData) {
      _specificFolderData = _telegramFilePickerRepo.getRecentImagesAndVideos().listen((data) {
        debugPrint("path of data: ${data?.file.path}");
        add(TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(data));
      });
    } else {
      _specificFolderData = _telegramFilePickerRepo
          .getSpecificFolderData(currentStateModel.getPathForGettingImagesFrom!)
          .listen((data) {
            add(TelegramFilePickerEvents.specificFolderDataStreamHandlerEvent(data));
          });
    }
  }

  void _specificFolderDataStreamHandlerEvent(
    _SpecificFolderDataStreamHandlerEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    if (event.file == null) return;
    debugPrint("coming file 2: ${event.file?.file}");

    var currentStateModel = state.telegramFilePickerStateModel;

    final value = TelegramFileImageEntity(
      file: event.file!.file,
      videoPlayerController:
          event.file!.isVideo ? VideoPlayerController.file(event.file!.file) : null,
      videoPreview:
          event.file!.isVideo
              ? await VideoThumbnail.thumbnailData(video: event.file!.file.path)
              : null,
      fileName: event.file!.fileName,
    );

    if (currentStateModel.specificFolderFilesPagination.length < Constants.perPage) {
      currentStateModel = currentStateModel.copyWith(
        specificFolderFilesPagination: [...currentStateModel.specificFolderFilesPagination, value],
      );
    }

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _paginateSpecificFolderDataEvent(
    _PaginateSpecificFolderDataEvent event,
    Emitter<TelegramFilePickerStates> emit,
  ) async {
    final data = ListPaginationChecker.instance.paginateList(
      wholeList: state.telegramFilePickerStateModel.specificFolderFilesAll,
      currentList: state.telegramFilePickerStateModel.specificFolderFilesPagination,
    );

    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      specificFolderFilesPagination: [
        ...state.telegramFilePickerStateModel.specificFolderFilesPagination,
        ...data,
      ],
    );

    _emitter(currentStateModel: currentStateModel, emit: emit);
  }

  void _emitter({
    required TelegramFilePickerStateModel currentStateModel,
    required Emitter<TelegramFilePickerStates> emit,
  }) async {
    switch (state) {
      case Picker$InitialState():
        emit(TelegramFilePickerStates.initial(currentStateModel));
        break;
      case Picker$GalleryFileState():
        emit(TelegramFilePickerStates.galleryFilePickerState(currentStateModel));
        break;
      case Picker$FilesState():
        emit(TelegramFilePickerStates.filesPickerState(currentStateModel));
        break;
      case Picker$AudioFilesState():
        emit(TelegramFilePickerStates.audioFilesPickerState(currentStateModel));
        break;
    }
  }

  TelegramFilePickerStateModel addOnStreamOfValuesInPaginationList(TelegramFileImageEntity value) {
    if (state.telegramFilePickerStateModel.galleryPathPagination.length >= Constants.perPage) {
      return state.telegramFilePickerStateModel;
    }
    final currentGalleryPath = List.of(state.telegramFilePickerStateModel.galleryPathPagination);
    currentGalleryPath.add(value);
    final currentStateModel = state.telegramFilePickerStateModel.copyWith(
      galleryPathPagination: currentGalleryPath,
    );
    return currentStateModel;
  }

  TelegramFilePickerStateModel addToRecentFiles({
    required TelegramFilePickerStateModel currentStateModel,
    required TelegramFileImageEntity value,
  }) {
    currentStateModel = currentStateModel.copyWith(
      recentFiles: [...currentStateModel.recentFiles, value],
    );
    if (currentStateModel.recentFilesPagination.length < Constants.perPage) {
      currentStateModel = currentStateModel.copyWith(
        recentFilesPagination: [...currentStateModel.recentFilesPagination, value],
      );
    }
    return currentStateModel;
  }

  TelegramFilePickerStateModel _removeOrAddEntity({
    required TelegramFilePickerStateModel currentStateModel,
    required TelegramFileImageEntity? value,
  }) {
    if (value == null) return currentStateModel;
    final pickedFiles = List.of(currentStateModel.pickedFiles);
    final findEntity = pickedFiles.firstWhereOrNull((el) => el.uuid == value.uuid);
    if (findEntity != null) {
      pickedFiles.removeWhere((el) => el.uuid == value.uuid);
    } else {
      pickedFiles.add(value);
    }
    currentStateModel = currentStateModel.copyWith(pickedFiles: pickedFiles);

    return currentStateModel;
  }

  @override
  Future<void> close() async {
    await _fileStreamData?.cancel();
    await _recentFileData?.cancel();
    await _specificFolderData?.cancel();
    add(const TelegramFilePickerEvents.closePopupEvent());
    _openButtonSectionTimer?.cancel();
    return super.close();
  }
}
