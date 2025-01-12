import 'package:yahay/src/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/src/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/src/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

class VideoChatFeatureRepoImpl implements VideoChatFeatureRepo {
  final VideoChatFeatureDataSource _dataSource;

  VideoChatFeatureRepoImpl(this._dataSource);

  @override
  Future<bool> startVideoChat(VideoChatEntity videoChatEntity) =>
      _dataSource.startVideoChat(videoChatEntity);

  @override
  Future<bool> videoChatEntrance(VideoChatEntity videoChatEntity) =>
      _dataSource.videoChatEntrance(videoChatEntity);

  @override
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity) =>
      _dataSource.leaveTheChat(videoChatEntity);

  @override
  Future<void> streamTheVideo({
    required VideoChatEntity videoChatEntity,
  }) =>
      _dataSource.streamTheVideo(
        videoChatEntity: videoChatEntity,
      );
}
