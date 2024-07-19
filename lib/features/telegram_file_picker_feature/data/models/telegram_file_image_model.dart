import 'package:flutter/cupertino.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFileImageModel extends TelegramFileImageEntity {
  TelegramFileImageModel({
    super.file,
    super.cameraController,
    super.videoPlayerController,
    super.videoPreview,
    super.fileName,
    super.selected,
  });

  Future<void> controllerInit() async {
    await cameraController?.initialize();
  }

  static TelegramFileImageModel? fromEntity(TelegramFileImageEntity? entity) {
    if (entity == null) return null;
    return TelegramFileImageModel(
      file: entity.file,
      cameraController: entity.cameraController,
      videoPlayerController: entity.videoPlayerController,
      videoPreview: entity.videoPreview,
      fileName: entity.fileName,
      selected: entity.selected,
    );
  }

  String fileSize() {
    if (file == null) return "0.0";
    try {
      final kb = file!.lengthSync() / 1024;
      if (kb < 1024) return "${kb.toStringAsFixed(2)} KB";
      final mb = kb / 1024;
      if (mb < 1024) return "${mb.toStringAsFixed(2)} MB";
      final gb = mb / 1024;
      return "${gb.toStringAsFixed(2)} GB";
    } catch (e) {
      debugPrint("file size error is: $e");
      return '';
    }
  }
}
