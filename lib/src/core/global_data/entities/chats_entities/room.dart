import 'package:flutter/foundation.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';

@immutable
class Room {
  final int? id;
  final int? chatId;
  final Chat? chat; // model if it will be needed
  final String? offer;
  final String? answer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Room({
    required this.id,
    required this.chatId,
    required this.chat,
    required this.offer,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });
}
