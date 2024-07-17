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
}
