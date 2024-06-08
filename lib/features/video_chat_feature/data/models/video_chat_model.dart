import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';

class VideoChatModel extends VideoChatEntity {
  VideoChatModel({
    required super.chatChannelName,
    super.channelAcception = false,
    super.channelCreator,
  });
}
