import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

class VideoChatEntity {
  RTCVideoRenderer? videoRenderer;
  final String videoChatId; // for double security
  final ChatModel? chat;
  final UserModel? user;

  VideoChatEntity({
    required this.videoRenderer,
    required this.chat,
    required this.user,
  }) : videoChatId = const Uuid().v4();
}
