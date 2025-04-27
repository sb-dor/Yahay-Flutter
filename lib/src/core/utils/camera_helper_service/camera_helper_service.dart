// import 'dart:collection';
// import 'package:image/image.dart' as img;
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';

/// [for future usage only]

class CameraHelperService {
  late List<CameraDescription> _cameras;

  UnmodifiableListView<CameraDescription> get cameras => UnmodifiableListView(_cameras);

  // init this one in main func
  Future<void> initCameras() async {
    _cameras = await availableCameras();
  }

  // Uint8List convertImageToJpeg(CameraImage image) {
  //   final int width = image.width;
  //   final int height = image.height;
  //   final int uvRowStride = image.planes[1].bytesPerRow;
  //   final int uvPixelStride = image.planes[1].bytesPerPixel ?? 1;
  //
  //   final img.Image imgImage = img.Image(width: width, height: height);
  //
  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width; x++) {
  //       final int uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;
  //       final int index = y * width + x;
  //
  //       final int yp = image.planes[0].bytes[index];
  //       final int up = image.planes[1].bytes[uvIndex];
  //       final int vp = image.planes[2].bytes[uvIndex];
  //
  //       // Compute RGB values
  //       int r = (yp + 1.402 * (vp - 128)).round();
  //       int g = (yp - 0.344136 * (up - 128) - 0.714136 * (vp - 128)).round();
  //       int b = (yp + 1.772 * (up - 128)).round();
  //
  //       imgImage.setPixel(
  //         x,
  //         y,
  //         img.convertColor(img.ColorRgb8(r, g, b)),
  //       );
  //     }
  //   }
  //   return Uint8List.fromList(img.encodeJpg(imgImage, quality: 80));
  // }
  //
  // Uint8List? convertYUV420toImage(
  //   CameraImage image, {
  //   bool frontCamera = false,
  // }) {
  //   try {
  //     final int width = image.width;
  //     final int height = image.height;
  //
  //     final int yRowStride = image.planes[0].bytesPerRow;
  //     final int uvRowStride = image.planes[1].bytesPerRow;
  //     final int uvPixelStride = image.planes[1].bytesPerPixel!;
  //
  //     img.Image rgbImage = img.Image(width: width, height: height);
  //
  //     for (int y = 0; y < height; y++) {
  //       for (int x = 0; x < width; x++) {
  //         final int yIndex = y * yRowStride + x;
  //         final int uvIndex = (y >> 1) * uvRowStride + (x >> 1) * uvPixelStride;
  //
  //         final int yValue = image.planes[0].bytes[yIndex];
  //         final int uValue = image.planes[1].bytes[uvIndex];
  //         final int vValue = image.planes[2].bytes[uvIndex];
  //
  //         final int r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
  //         final int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
  //             .clamp(0, 255)
  //             .toInt();
  //         final int b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();
  //
  //         rgbImage.setPixel(x, y, img.ColorRgb8(r, g, b));
  //       }
  //     }
  //
  //     // if it's from camera rotate image -90 degrees
  //     // to fix the front and back camera issue
  //     if (frontCamera) {
  //       rgbImage = img.copyRotate(rgbImage, angle: -90);
  //     } else {
  //       // if it's not rotate 90 degrees
  //       rgbImage = img.copyRotate(rgbImage, angle: 90);
  //     }
  //
  //     return Uint8List.fromList(img.encodeJpg(rgbImage));
  //   } catch (e) {
  //     debugPrint(">>>>>>>>>>>> ERROR:$e");
  //   }
  //   return null;
  // }
  //
  // Uint8List makeImageFromCameraStream(CameraImage image) {
  //   img.Image createImage = img.Image.fromBytes(
  //     width: image.width,
  //     height: image.height,
  //     bytes: image.planes[0].bytes.buffer,
  //   );
  //   Uint8List jpg = Uint8List.fromList(img.encodeJpg(createImage));
  //   return jpg;
  // }
}
