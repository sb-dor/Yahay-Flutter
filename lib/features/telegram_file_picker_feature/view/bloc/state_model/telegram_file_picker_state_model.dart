import 'dart:collection';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFilePickerStateModel {
  final List<TelegramFileImageEntity> _galleryPathFiles = [];

  UnmodifiableListView<TelegramFileImageEntity> get galleryPathFiles => UnmodifiableListView(
        _galleryPathFiles,
      );

  void setGalleryPathFiles(TelegramFileImageEntity value) => _galleryPathFiles.add(value);

  void clearAllGalleryPath() => _galleryPathFiles.clear();
}
