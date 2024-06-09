import 'dart:collection';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraHelperService {
  late List<CameraDescription> _cameras;

  UnmodifiableListView<CameraDescription> get cameras => UnmodifiableListView(_cameras);

  // init this one in main func
  Future<void> initCameras() async {
    final list = await availableCameras();
    debugPrint("all camera list settings list: ${list.length}");
    _cameras = await availableCameras();
  }

  Uint8List convertImageToJpeg(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

    final img.Image imgImage = img.Image(width: width, height: height);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;
        final int index = y * width + x;

        final int yp = image.planes[0].bytes[index];
        final int up = image.planes[1].bytes[uvIndex];
        final int vp = image.planes[2].bytes[uvIndex];

        // Compute RGB values
        int r = (yp + 1.402 * (vp - 128)).round();
        int g = (yp - 0.344136 * (up - 128) - 0.714136 * (vp - 128)).round();
        int b = (yp + 1.772 * (up - 128)).round();

        imgImage.setPixel(
          x,
          y,
          img.convertColor(img.ColorRgb8(r, g, b)),
        );
      }
    }

    return Uint8List.fromList(img.encodeJpg(imgImage, quality: 80));
  }
}
