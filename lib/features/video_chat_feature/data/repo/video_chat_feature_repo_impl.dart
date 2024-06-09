
import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

class VideoChatFeatureRepoImpl implements VideoChatFeatureRepo {
  @override
  Future<bool> joinToChat(VideoChatEntity videoChatEntity) {
    // TODO: implement joinToChat
    throw UnimplementedError();
  }

  @override
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity) {
    // TODO: implement leaveTheChat
    throw UnimplementedError();
  }

  @override
  Future<void> streamTheVideo(Uint8List int8) {
    // TODO: implement streamTheVideo
    throw UnimplementedError();
  }
}
