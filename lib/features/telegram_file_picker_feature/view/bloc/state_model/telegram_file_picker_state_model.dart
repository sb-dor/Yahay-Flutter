import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFilePickerStateModel {
  final List<TelegramFileImageEntity> _galleryPathFiles = [];

  final List<TelegramFileImageEntity> _galleryPathPagination = [];

  final List<TelegramFileImageEntity> _pickedFiles = [];

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathFiles => UnmodifiableListView(
        _galleryPathFiles,
      );

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathPagination => UnmodifiableListView(
        _galleryPathPagination,
      );

  List<TelegramFileImageEntity?> get clonedPickedFiles =>
      _pickedFiles.map((e) => TelegramFileImageModel.fromEntity(e)).toList();

  StreamSubscription<File?>? _fileStreamData;

  StreamSubscription<File?>? get fileStreamData => _fileStreamData;

  void setGalleryPathFiles(TelegramFileImageEntity value) => _galleryPathFiles.add(value);

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

  void addOnStreamOfValuesInPaginationList(TelegramFileImageEntity value) {
    if (_galleryPathPagination.length >= Constants.perPage) return;
    _galleryPathPagination.add(value);
  }

  void addToPagination(List<TelegramFileImageEntity> list) => _galleryPathPagination.addAll(list);

  void initFileStreamData(StreamSubscription<File?> stream) => _fileStreamData = stream;

  void closeStreamSubs() => _fileStreamData?.cancel();

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
}
