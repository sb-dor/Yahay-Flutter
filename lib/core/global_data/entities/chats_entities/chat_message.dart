import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

@immutable
class ChatMessage {
  final int? id;
  final User? user;
  final User? relatedToUser;
  final Chat? chat;
  final String? message;
  final String? chatMessageUUID;
  final File? file;
  final String? imageUrl;
  final String? videoUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final bool? messageSent;


  const ChatMessage({
    required this.id,
    required this.user,
    required this.relatedToUser,
    required this.chat,
    required this.message,
    required this.chatMessageUUID,
    required this.file,
    required this.imageUrl,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.messageSent,
  });
}
