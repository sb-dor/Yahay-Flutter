import 'package:yahay/src/features/video_chat_feature/models/video_chat_model.dart';

import 'video_chat_feature_data_source.dart';

abstract interface class VideoChatFeatureRepo {
  // for starting the video chat
  Future<bool> startVideoChat(VideoChatModel videoChatEntity);

  // for entrance in video chat if someone has already called
  Future<bool> videoChatEntrance(VideoChatModel videoChatEntity);

  // for leaving the video chat
  Future<bool> leaveTheChat(VideoChatModel videoChatEntity);

  // streaming the video data feature
  Future<void> streamTheVideo({
    required VideoChatModel videoChatEntity,
  });
}

class VideoChatFeatureRepoImpl implements VideoChatFeatureRepo {
  final VideoChatFeatureDataSource _dataSource;

  VideoChatFeatureRepoImpl(this._dataSource);

  @override
  Future<bool> startVideoChat(VideoChatModel videoChatEntity) =>
      _dataSource.startVideoChat(videoChatEntity);

  @override
  Future<bool> videoChatEntrance(VideoChatModel videoChatEntity) =>
      _dataSource.videoChatEntrance(videoChatEntity);

  @override
  Future<bool> leaveTheChat(VideoChatModel videoChatEntity) =>
      _dataSource.leaveTheChat(videoChatEntity);

  @override
  Future<void> streamTheVideo({
    required VideoChatModel videoChatEntity,
  }) =>
      _dataSource.streamTheVideo(
        videoChatEntity: videoChatEntity,
      );
}
