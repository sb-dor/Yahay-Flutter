import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/core/global_data/entities/chats_entities/room.dart';

@immutable
class Chat {
  final int? id;
  final String? uuid;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  final bool? videoChatStreaming;

  //
  final ChatMessage? lastMessage;
  final List<ChatParticipant>? participants;
  final List<ChatMessage>? messages;
  final Room? videoChatRoom;

  const Chat({
    required this.id,
    required this.uuid,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    required this.participants,
    required this.messages,
    required this.videoChatStreaming,
    required this.videoChatRoom,
  });
}
