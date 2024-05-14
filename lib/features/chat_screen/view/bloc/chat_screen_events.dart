import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

@immutable
class ChatScreenEvents {}

// init chat on entering to the screen (if chat was already created)
@immutable
class InitChatScreenEvent extends ChatScreenEvents {
  final Chat? chat;
  final User? user; // temp for creating temp chat if chat does not exist
  final Sink<ChatScreenEvents> events;

  InitChatScreenEvent(this.chat, this.user, this.events);
}

@immutable
class RemoveAllTempCreatedChatsEvent extends ChatScreenEvents {}

@immutable
class HandleChatScreenEvent extends ChatScreenEvents {
  final PusherEvent? event;

  HandleChatScreenEvent(this.event);
}

// sending message event
@immutable
class SendMessageEvent extends ChatScreenEvents {
  final Sink<ChatScreenEvents> events;

  SendMessageEvent(this.events);
}
