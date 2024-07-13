import 'dart:io';

import 'package:camera/camera.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class TelegramFileImageEntity {
  final String uuid;
  File? file;
  CameraController? cameraController;
  VideoPlayerController? videoPlayerController;
  bool selected;

  TelegramFileImageEntity({
    this.file,
    this.cameraController,
    this.videoPlayerController,
    this.selected = false,
  }) : uuid = const Uuid().v4();
}
