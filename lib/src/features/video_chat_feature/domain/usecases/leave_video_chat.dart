import 'package:flutter/foundation.dart';
import 'package:yahay/src/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/src/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

@immutable
class LeaveVideoChat {
  final VideoChatFeatureRepo _repo;

  const LeaveVideoChat(this._repo);

  Future<bool> leaveVideoChat(VideoChatEntity videoChat) => _repo.leaveTheChat(videoChat);
}
