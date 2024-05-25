import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/injections/injections.dart';

class ChatsStateModel {
  PusherChannelsClient? _pusherClientService;

  StreamSubscription<void>? _channelSubscription;

  PusherChannelsClient? get pusherClientService => _pusherClientService;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  void setToPusherClient(PusherChannelsClient? client) {
    _pusherClientService = client;
  }

  void setToSubscription(StreamSubscription<void>? subs) {
    _channelSubscription = subs;
  }

  Future<void> disposeClientAndSubs() async {
    await _pusherClientService?.disconnect();
    await _channelSubscription?.cancel();
    _pusherClientService?.dispose();
    _pusherClientService = null;
    _channelSubscription = null;
  }

  void setChat(List<Chat> list) => _chats = list;

  void addChat(Chat chat) {
    final findChat = _chats.firstWhereOrNull((e) => e.id == chat.id && e.uuid == chat.uuid);
    if (findChat != null) {
      _chats[_chats.indexWhere((e) => e.id == chat.id && e.uuid == chat.uuid)] =
          ChatModel.fromEntity(findChat)!.copyWith(
        lastMessage: ChatMessageModel.fromEntity(chat.lastMessage),
      );
    } else {
      final currentUser = snoopy<AuthBloc>().states.value.authStateModel.user;
      chat.participants?.removeWhere((e) => e.user?.id == currentUser?.id);
      _chats.add(chat);
    }
  }

  Future<void> clearAll() async {
    await disposeClientAndSubs();
    _chats.clear();
  }
}
