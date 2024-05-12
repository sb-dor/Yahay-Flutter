import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/user.dart';

@immutable
class ChatMessage {
  final User? user;
  final User? relatedToUser;
  final String? message;
  final String? imageUrl;
  final String? videoUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const ChatMessage({
    required this.user,
    required this.relatedToUser,
    required this.message,
    required this.imageUrl,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}
