import 'dart:typed_data';

import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';

class VideoChatFeatureDataSourceImpl implements VideoChatFeatureDataSource {
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
