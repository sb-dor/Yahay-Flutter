import 'package:camera/camera.dart';
import 'package:yahay/core/global_data/entities/user.dart';

class VideoChatEntity {
  final CameraController cameraController;
  final String chatChannelName;
  final User? user;
  bool channelAcception;

  VideoChatEntity({
    required this.user,
    required this.cameraController,
    required this.chatChannelName,
    this.channelAcception = false,
  });
}
