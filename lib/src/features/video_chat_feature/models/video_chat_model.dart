import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

class VideoChatModel {
  RTCVideoRenderer? videoRenderer;
  final String videoChatId; // for double security
  final ChatModel? chat;
  final UserModel? user;

  VideoChatModel({
    required this.videoRenderer,
    required this.chat,
    required this.user,
  }) : videoChatId = const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      // "image_data": videoRenderer,
      "user_id": user?.id,
      "chat_id": chat?.id,
      "chat_uuid": chat?.uuid,
      "sending__uuid": videoChatId,
    };
  }
}
