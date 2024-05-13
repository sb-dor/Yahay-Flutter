import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_participant.dart';

@immutable
class Chat {
  final int? id;
  final String? uuid;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  //
  final ChatMessage? lastMessage;
  final List<ChatParticipant>? participants;
  final List<ChatMessage>? messages;

  const Chat({
    required this.id,
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    required this.participants,
    required this.messages,
  });
}
