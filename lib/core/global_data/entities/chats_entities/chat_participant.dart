import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_participant_status.dart';
import 'package:yahay/core/global_data/entities/user.dart';

@immutable
class ChatParticipant {
  final int? id;
  final User? user;
  final Chat? chat;
  final ChatParticipantStatus? status;
  final bool? muted;
  final String? participateAt;

  const ChatParticipant({
    required this.id,
    required this.user,
    required this.chat,
    required this.status,
    required this.muted,
    required this.participateAt,
  });
}
