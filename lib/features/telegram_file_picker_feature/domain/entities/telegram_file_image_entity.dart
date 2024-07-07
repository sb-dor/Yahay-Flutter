import 'dart:io';

import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

class TelegramFileImageEntity {
  File? file;
  CameraController? cameraController;
  VideoPlayerController? videoPlayerController;
  bool selected;

  TelegramFileImageEntity({
    this.file,
    this.cameraController,
    this.videoPlayerController,
    this.selected = false,
  });
}
