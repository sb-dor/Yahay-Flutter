// ignore_for_file: invalid_annotation_target

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

part 'chat_message_model.freezed.dart';

part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    int? id,
    UserModel? user,
    @JsonKey(name: "related_to_user") UserModel? relatedToUser,
    ChatModel? chat,
    String? message,
    @JsonKey(name: "chat_message_uuid") String? chatMessageUUID,
    @JsonKey(includeFromJson: false, includeToJson: false) File? file,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "video_url") String? videoUrl,
    @JsonKey(name: "message_seen_at") String? messageSeenAt,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    @JsonKey(name: "deleted_at") String? deletedAt,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? messageSent,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, Object?> json) => _$ChatMessageModelFromJson(json);
}
