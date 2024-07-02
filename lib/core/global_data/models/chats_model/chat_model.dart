// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/core/global_data/models/room_models/room_model.dart';

part 'chat_model.freezed.dart';

part 'chat_model.g.dart';

bool? _fromJsonVideoChatStreaming(dynamic json) {
  if (json is int) {
    return json == 1;
  }
  return json as bool?;
}

@freezed
class ChatModel extends Chat with _$ChatModel {
  const factory ChatModel({
    int? id,
    @JsonKey(name: "chat_uuid") String? uuid,
    String? name,
    String? description,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,

    //
    @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
    @JsonKey(name: "participants") List<ChatParticipantModel>? participants,
    @JsonKey(name: "messages") List<ChatMessageModel>? messages,
    @JsonKey(name: "chat_video_room") RoomModel? videoChatRoom,
    @JsonKey(
      name: "video_chat_streaming",
      includeFromJson: true,
      includeToJson: false,
      defaultValue: false,
      fromJson: _fromJsonVideoChatStreaming,
    )
    bool? videoChatStreaming,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) => _$ChatModelFromJson(json);

  static ChatModel? fromEntity(Chat? chat) {
    if (chat == null) return null;
    return ChatModel(
      id: chat.id,
      uuid: chat.uuid,
      name: chat.name,
      description: chat.description,
      imageUrl: chat.imageUrl,
      createdAt: chat.createdAt,
      updatedAt: chat.updatedAt,
      lastMessage: ChatMessageModel.fromEntity(chat.lastMessage),
      participants: chat.participants?.map((e) => ChatParticipantModel.fromEntity(e)!).toList(),
      messages: chat.messages?.map((e) => ChatMessageModel.fromEntity(e)!).toList(),
      videoChatStreaming: chat.videoChatStreaming,
      videoChatRoom: RoomModel.fromEntity(chat.videoChatRoom),
    );
  }
}
