import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class JoinToVideoChat {
  final VideoChatFeatureRepo _repo;

  const JoinToVideoChat(this._repo);

  Future<bool> joinToVideoChat(VideoChatEntity videoChat) => _repo.joinToChat(videoChat);
}
