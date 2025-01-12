import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';

class VideoChatEntity {
  RTCVideoRenderer? videoRenderer;
  final String videoChatId; // for double security
  final Chat? chat;
  final User? user;

  VideoChatEntity({
    required this.videoRenderer,
    required this.chat,
    required this.user,
  }) : videoChatId = const Uuid().v4();
}
