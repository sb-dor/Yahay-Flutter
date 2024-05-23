import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chat_participant_model/chat_participant_model.dart';

@immutable
class ChatFunctions extends Chat {
  const ChatFunctions({
    required super.id,
    required super.uuid,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.lastMessage,
    required super.participants,
    required super.messages,
  });

  static ChatFunctions? fromEntity(Chat? chat) {
    if (chat == null) return null;
    return ChatFunctions(
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
    );
  }

  String getWrappedName() {
    if (name == null) return '';
    if ((name ?? '').isEmpty) return '';
    if ((name?.length ?? 0) < 1) return name?[0] ?? '';
    return "${name?[0].toUpperCase()} ${name?[(name?.length ?? 0) - 1].toUpperCase()}";
  }
}
