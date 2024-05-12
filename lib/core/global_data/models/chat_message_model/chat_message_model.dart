import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';

part 'chat_message_model.freezed.dart';

part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel extends ChatMessage with _$ChatMessageModel {
  const factory ChatMessageModel({
    UserModel? user,
    UserModel? relatedToUser,
    String? message,
    String? imageUrl,
    String? videoUrl,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, Object?> json) => _$ChatMessageModelFromJson(json);
}
