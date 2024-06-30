import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';

class VideoChatModel extends VideoChatEntity {
  VideoChatModel({
    super.videoRenderer,
    UserModel? user,
    ChatModel? chat,
  }) : super(user: user, chat: chat);

  static VideoChatModel? fromEntity(VideoChatEntity? entity) {
    if (entity == null) return null;
    return VideoChatModel(
      videoRenderer: entity.videoRenderer,
      user: UserModel.fromEntity(entity.user),
      chat: ChatModel.fromEntity(entity.chat),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "image_data": videoRenderer,
      "user_id": user?.id,
      "chat_id": chat?.id,
      "chat_uuid": chat?.uuid,
      "sending__uuid": videoChatId,
    };
  }
}
