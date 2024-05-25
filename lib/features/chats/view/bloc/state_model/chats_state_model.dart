import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';

class ChatsStateModel {
  PusherChannelsClient? _pusherClientService;

  StreamSubscription<void>? _channelSubscription;

  PusherChannelsClient? get pusherClientService => _pusherClientService;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  void setToPusherClient(PusherChannelsClient? client) {
    _pusherClientService = client;
  }

  void setToSubscription(StreamSubscription<void>? subs) {
    _channelSubscription = subs;
  }

  void disposeClientAndSubs() async {
    await _pusherClientService?.disconnect();
    await _channelSubscription?.cancel();
    _pusherClientService?.dispose();
    _pusherClientService = null;
    _channelSubscription = null;
  }

  List<Chat> chats = [];
}
