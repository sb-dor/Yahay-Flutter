import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';

abstract class VideoChatFeatureRepo {
  // for starting the video chat
  Future<bool> startVideoChat(VideoChatEntity videoChatEntity);

  // for entrance in video chat if someone has already called
  Future<bool> videoChatEntrance(VideoChatEntity videoChatEntity);

  // for leaving the video chat
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity);

  // streaming the video data feature
  Future<void> streamTheVideo({
    required VideoChatEntity videoChatEntity,
  });
}
