import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chat_participant_model/chat_participant_model.dart';

part 'chat_model.freezed.dart';

part 'chat_model.g.dart';

@freezed
class ChatModel extends Chat with _$ChatModel {
  const factory ChatModel({
    int? id,
    @JsonKey(name: "chat_uuid") String? uuid,
    String? name,
    String? description,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,

    //
    @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
    @JsonKey(name: "participants") List<ChatParticipantModel>? participants,
    @JsonKey(name: "messages") List<ChatMessageModel>? messages,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) => _$ChatModelFromJson(json);

  static ChatModel? fromEntity(Chat? chat) {
    if (chat == null) return null;
    return ChatModel(
      id: chat.id,
      uuid: chat.uuid,
      name: chat.name,
      description: chat.description,
      createdAt: chat.createdAt,
      updatedAt: chat.updatedAt,
      lastMessage: ChatMessageModel.fromEntity(chat.lastMessage),
      participants: chat.participants?.map((e) => ChatParticipantModel.fromEntity(e)!).toList(),
      messages: chat.messages?.map((e) => ChatMessageModel.fromEntity(e)!).toList(),
    );
  }
}
