import 'package:camera/camera.dart';

class CameraHelperService {
  late List<CameraDescription> _cameras;

  List<CameraDescription> get cameras => _cameras;

  // init this one in main func
  Future<void> initCameras() async {
    _cameras = await availableCameras();
  }
}
