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

  Future<Uint8List?> convertYUV420toImage(CameraImage cameraImage) async {
    try {
      final imageWidth = cameraImage.width;
      final imageHeight = cameraImage.height;

      final yBuffer = cameraImage.planes[0].bytes;
      final uBuffer = cameraImage.planes[1].bytes;
      final vBuffer = cameraImage.planes[2].bytes;

      final int yRowStride = cameraImage.planes[0].bytesPerRow;
      final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

      final int uvRowStride = cameraImage.planes[1].bytesPerRow;
      final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

      final image = img.Image(width: imageWidth, height: imageHeight);

      for (int h = 0; h < imageHeight; h++) {
        int uvh = (h / 2).floor();

        for (int w = 0; w < imageWidth; w++) {
          int uvw = (w / 2).floor();

          final yIndex = (h * yRowStride) + (w * yPixelStride);

          // Y plane should have positive values belonging to [0...255]
          final int y = yBuffer[yIndex];

          // U/V Values are subsampled i.e. each pixel in U/V chanel in a
          // YUV_420 image act as chroma value for 4 neighbouring pixels
          final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

          // U/V values ideally fall under [-0.5, 0.5] range. To fit them into
          // [0, 255] range they are scaled up and centered to 128.
          // Operation below brings U/V values to [-128, 127].
          final int u = uBuffer[uvIndex];
          final int v = vBuffer[uvIndex];

          // Compute RGB values per formula above.
          int r = (y + v * 1436 / 1024 - 179).round();
          int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
          int b = (y + u * 1814 / 1024 - 227).round();

          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          image.setPixelRgb(w, h, r, g, b);
        }
      }

      return Uint8List.fromList(img.encodeJpg(image));
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  Uint8List makeImageFromCameraStream(CameraImage image) {
    img.Image createImage = img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
    );
    Uint8List jpg = Uint8List.fromList(img.encodeJpg(createImage));
    return jpg;
  }
}
