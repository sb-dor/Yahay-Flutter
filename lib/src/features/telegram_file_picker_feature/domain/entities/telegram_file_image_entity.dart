import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class TelegramFileImageEntity {
  final String uuid;
  File? file;
  CameraController? cameraController;
  Uint8List? videoPreview;
  VideoPlayerController? videoPlayerController;
  String? fileName;
  bool selected;

  String? originalImagePath;

  TelegramFileImageEntity({
    this.file,
    this.cameraController,
    this.videoPlayerController,
    this.videoPreview,
    this.fileName,
    this.selected = false,
    this.originalImagePath,
  }) : uuid = const Uuid().v4();
}
