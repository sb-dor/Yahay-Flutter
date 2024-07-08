import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFilePickerStateModel {
  final List<TelegramFileImageEntity> _galleryPathFiles = [];

  final List<TelegramFileImageEntity> _galleryPathPagination = [];

  StreamSubscription<File?>? _fileStreamData;

  StreamSubscription<File?>? get fileStreamData => _fileStreamData;

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathFiles => UnmodifiableListView(
        _galleryPathFiles,
      );

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathPagination => UnmodifiableListView(
        _galleryPathPagination,
      );

  void setGalleryPathFiles(TelegramFileImageEntity value) => _galleryPathFiles.add(value);

  void clearAllGalleryPath() => _galleryPathFiles.clear();

  void clearAllGalleryPaginationPath() => _galleryPathPagination.clear();

  void addToPagination(List<TelegramFileImageEntity> list) => _galleryPathPagination.addAll(list);

  void initFileStreamData(StreamSubscription<File?> stream) => _fileStreamData = stream;

  void closeStreamSubs() => _fileStreamData?.cancel();
}
