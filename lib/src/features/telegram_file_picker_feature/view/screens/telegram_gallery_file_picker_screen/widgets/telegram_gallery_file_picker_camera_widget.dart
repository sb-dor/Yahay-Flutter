import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelegramGalleryFilePickerCameraWidget extends StatelessWidget {
  final CameraController cameraController;

  const TelegramGalleryFilePickerCameraWidget({
    super.key,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CameraPreview(cameraController),
              ),
            ),
          ),
        ),
        const Positioned.fill(
          child: Center(
            child: Icon(
              CupertinoIcons.camera_fill,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
