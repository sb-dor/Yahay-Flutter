import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class StreamTheVideo {
  final VideoChatFeatureRepo _repo;

  const StreamTheVideo(this._repo);

  Future<void> streamTheVideo(Uint8List imageData) => _repo.streamTheVideo(imageData);
}
