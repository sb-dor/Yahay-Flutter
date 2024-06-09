import 'package:camera/camera.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

class VideoChatEntity {
  final Chat chat;
  final User? user;

  VideoChatEntity({
    required this.chat,
    required this.user,
  });
}
