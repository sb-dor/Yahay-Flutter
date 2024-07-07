import 'dart:io';

import 'package:camera/camera.dart';

class TelegramFileImageEntity {
  File? file;
  CameraController? cameraController;

  TelegramFileImageEntity({
    this.file,
    this.cameraController,
  });
}
