import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class StartVideoChat {
  final VideoChatFeatureRepo _repo;

  const StartVideoChat(this._repo);

  Future<bool> startVideoChat(VideoChatEntity videoChatEntity) =>
      _repo.startVideoChat(videoChatEntity);
}
