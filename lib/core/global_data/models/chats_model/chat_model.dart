import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';

part 'chat_model.freezed.dart';

part 'chat_model.g.dart';

@freezed
class ChatModel extends Chat with _$ChatModel {
  const factory ChatModel({
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,

    //
    @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) => _$ChatModelFromJson(json);
}
