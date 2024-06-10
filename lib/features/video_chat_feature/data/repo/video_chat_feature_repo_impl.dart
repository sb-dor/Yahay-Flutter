import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

class VideoChatFeatureRepoImpl implements VideoChatFeatureRepo {
  final VideoChatFeatureDataSource _dataSource;

  VideoChatFeatureRepoImpl(this._dataSource);

  @override
  Future<bool> joinToChat(VideoChatEntity videoChatEntity) =>
      _dataSource.joinToChat(videoChatEntity);

  @override
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity) =>
      _dataSource.leaveTheChat(videoChatEntity);

  @override
  Future<void> streamTheVideo(Uint8List int8) => _dataSource.streamTheVideo(int8);
}
