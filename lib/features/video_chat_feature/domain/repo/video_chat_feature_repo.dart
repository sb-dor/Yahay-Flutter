
import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';

abstract class VideoChatFeatureRepo {
  Future<bool> joinToChat(VideoChatEntity videoChatEntity);

  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity);

  Future<void> streamTheVideo(Uint8List int8);
}
