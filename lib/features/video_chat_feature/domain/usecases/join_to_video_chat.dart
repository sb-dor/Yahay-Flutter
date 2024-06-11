import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class VideoChatEntrance {
  final VideoChatFeatureRepo _repo;

  const VideoChatEntrance(this._repo);

  Future<bool> videoChatEntrance(VideoChatEntity videoChat) => _repo.videoChatEntrance(videoChat);
}
