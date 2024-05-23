import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';

@immutable
class ChatsEvents {}

@immutable
class GetUserChatsEvent extends ChatsEvents {
  final bool refresh;

  GetUserChatsEvent({this.refresh = false});
}

@immutable
class ChatListenerEvent extends ChatsEvents {
  final ChannelReadEvent? event;

  ChatListenerEvent(this.event);
}
