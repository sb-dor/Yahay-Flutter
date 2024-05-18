import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';

part 'chat_message_model.freezed.dart';

part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel extends ChatMessage with _$ChatMessageModel {
  const factory ChatMessageModel({
    UserModel? user,
    @JsonKey(name: "related_to_user") UserModel? relatedToUser,
    ChatModel? chat,
    String? message,
    String? chatMessageUUID,
    @JsonKey(includeFromJson: false, includeToJson: false) File? file,
    String? imageUrl,
    String? videoUrl,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    bool? messageSent,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, Object?> json) => _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessage? message) {
    return ChatMessageModel(
      user: UserModel.fromEntity(message?.user),
      relatedToUser: UserModel.fromEntity(message?.relatedToUser),
      chat: ChatModel.fromEntity(message?.chat),
      message: message?.message,
      chatMessageUUID: message?.chatMessageUUID,
      file: message?.file,
      imageUrl: message?.imageUrl,
      videoUrl: message?.videoUrl,
      createdAt: message?.createdAt,
      updatedAt: message?.updatedAt,
      deletedAt: message?.deletedAt,
      messageSent: message?.messageSent,
    );
  }
}
