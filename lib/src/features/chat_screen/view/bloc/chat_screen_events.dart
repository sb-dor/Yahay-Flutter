import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';

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
class HandleChatMessageEvent extends ChatScreenEvents {
  final ChannelReadEvent? event;

  HandleChatMessageEvent(this.event);
}

// sending message event
@immutable
class SendMessageEvent extends ChatScreenEvents {}

@immutable
class ChangeEmojiPicker extends ChatScreenEvents {
  final bool? value;

  ChangeEmojiPicker({this.value});
}
