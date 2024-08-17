import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';
import 'package:yahay/injections/injections.dart';

class TelegramFilePickerStateModel {
  //
  BuildContext get context => snoopy<GlobalContext>().globalContext.currentContext!;

  DraggableScrollableController? _draggableScrollableController;

  DraggableScrollableController? get draggableScrollableController =>
      _draggableScrollableController;

  final List<TelegramFileImageEntity> _galleryPathFiles = [];

  final List<TelegramFileImageEntity> _galleryPathPagination = [];

  final List<TelegramFileImageEntity> _recentFiles = [];

  final List<TelegramFileImageEntity> _recentFilesPagination = [];

  final List<TelegramFileImageEntity> _pickedFiles = [];

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathFiles => UnmodifiableListView(
        _galleryPathFiles,
      );

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathPagination => UnmodifiableListView(
        _galleryPathPagination,
      );

  UnmodifiableListView<TelegramFileImageEntity> get recentFiles => UnmodifiableListView(
        _recentFiles,
      );

  UnmodifiableListView<TelegramFileImageEntity> get recentFilesPagination => UnmodifiableListView(
        _recentFilesPagination,
      );

  List<TelegramFileImageEntity?> get clonedPickedFiles =>
      _pickedFiles.map((e) => TelegramFileImageModel.fromEntity(e)).toList();

  StreamSubscription<TelegramPathFolderFile?>? _fileStreamData;

  StreamSubscription<TelegramPathFolderFile?>? get fileStreamData =>
      _fileStreamData;

  StreamSubscription<TelegramPathFolderFile?>? _recentFileData;

  StreamSubscription<TelegramPathFolderFile?>? get recentFileData =>
      _recentFileData;

  bool _openBottomSectionButton = true;

  bool get openBottomSectionButton => _openBottomSectionButton;

  Timer? _openButtonSectionTimer;

  Timer? get openButtonSectionTimer => _openButtonSectionTimer;

  TelegramFileFolderEnum _filePickerScreenSelectedScreen =
      TelegramFileFolderEnum.recentDownloadsScreen;

  TelegramFileFolderEnum get filePickerScreenSelectedScreen => _filePickerScreenSelectedScreen;

  void selectScreen(TelegramFileFolderEnum screen) {
    _filePickerScreenSelectedScreen = screen;
  }

  void initDragScrollController(DraggableScrollableController controller) =>
      _draggableScrollableController = controller;

  void setGalleryPathFiles(TelegramFileImageEntity value) => _galleryPathFiles.add(value);

  void setOpenButtonSectionTimer(Timer? timer) {
    if ((_openButtonSectionTimer?.isActive ?? false)) {
      _openButtonSectionTimer?.cancel();
    }
    _openButtonSectionTimer = timer;
  }

  void setValueToOpenButtonSectionButton(bool value) {
    _openBottomSectionButton = value;
  }

  void clearAllGalleryPath({bool clearAll = true}) {
    if (_galleryPathFiles.isNotEmpty && !clearAll) {
      _galleryPathFiles.removeRange(1, _galleryPathFiles.length);
    } else {
      _galleryPathFiles.clear();
    }
  }

  void clearAllGalleryPaginationPath({bool clearAll = true}) {
    if (_galleryPathPagination.isNotEmpty && !clearAll) {
      _galleryPathPagination.removeRange(1, _galleryPathPagination.length);
    } else {
      _galleryPathPagination.clear();
    }
  }

  void clearRecentFiles() => _recentFiles.clear();

  void clearRecentPagFiles() => _recentFilesPagination.clear();

  Stream<TelegramFilePickerStates> addOnStreamOfValuesInPaginationList(
    TelegramFileImageEntity value, {
    Stream<TelegramFilePickerStates>? emitter,
  }) async* {
    if (_galleryPathPagination.length >= Constants.perPage) return;
    _galleryPathPagination.add(value);
    if (emitter != null) yield* emitter;
  }

  void addToRecentFiles(TelegramFileImageEntity value) {
    _recentFiles.add(value);
    if (_recentFilesPagination.length < Constants.perPage) {
      _recentFilesPagination.add(value);
    }
  }

  void addToPagination(List<TelegramFileImageEntity> list) => _galleryPathPagination.addAll(list);

  void addToRecentFilesPagination(List<TelegramFileImageEntity> list) =>
      _recentFilesPagination.addAll(list);

  void initFileStreamData(
    StreamSubscription<TelegramPathFolderFile?> stream,
  ) =>
      _fileStreamData = stream;

  void initRecentFileStreamData(
    StreamSubscription<TelegramPathFolderFile?> stream,
  ) =>
      _recentFileData = stream;

  void closeAllStreamSubs() {
    _fileStreamData?.cancel();
    _recentFileData?.cancel();
  }

  void removeOrAddEntity(TelegramFileImageEntity? value) {
    if (value == null) return;
    final findEntity = _pickedFiles.firstWhereOrNull((el) => el.uuid == value.uuid);
    if (findEntity != null) {
      _pickedFiles.removeWhere((el) => el.uuid == value.uuid);
    } else {
      _pickedFiles.add(value);
    }
  }

  bool isFileInsidePickedFiles(TelegramFileImageEntity? value) =>
      _pickedFiles.any((el) => el.uuid == value?.uuid);

  String? getFileBaseName(File? file) {
    try {
      return basename(file!.path);
    } catch (e) {
      debugPrint("get file base name error is: $e");
      return null;
    }
  }
}
