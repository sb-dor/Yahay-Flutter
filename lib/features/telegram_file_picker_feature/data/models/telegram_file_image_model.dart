import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFileImageModel extends TelegramFileImageEntity {
  TelegramFileImageModel({super.file, super.cameraController});

  Future<void> controllerInit() async {
    await cameraController?.initialize();
  }
}
