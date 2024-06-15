import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class StreamTheVideo {
  final VideoChatFeatureRepo _repo;

  const StreamTheVideo(this._repo);

  Future<void> streamTheVideo({
    required VideoChatEntity videoChatEntity,
  }) =>
      _repo.streamTheVideo(
        videoChatEntity: videoChatEntity,
      );
}
