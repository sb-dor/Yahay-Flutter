import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';

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

  const Chat({
    required this.id,
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
  });
}
