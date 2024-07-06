import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_functions.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';

class ChatScreenStateModel {
  StreamSubscription<void>? _channelSubscription;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsClient? get pusherChannelClient => _pusherChannelsClient;

  final TextEditingController _messageController = TextEditingController();

  TextEditingController get messageController => _messageController;

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  Chat? _currentChat;

  Chat? get currentChat => _currentChat;

  ChatModel? get currentChatModel => ChatModel.fromEntity(_currentChat);

  ChatFunctions? get currentChatFunctions => ChatFunctions.fromEntity(_currentChat);

  File? _pickedFile;

  File? get pickedFile => _pickedFile;

  User? _currentUser, _relatedUser;

  User? get relatedUser => _relatedUser;

  User? get currentUser => _currentUser;

  bool _showEmojiPicker = false;

  bool get showEmojiPicker => _showEmojiPicker;

  void setChat(Chat? chat, {bool setChatMessages = true}) {
    if (chat == null) return;
    _currentChat = chat;
    if (setChatMessages) _messages.addAll((chat.messages ?? []).reversed.toList());
  }

  void setToFile(File? file) => _pickedFile = file;

  void setToRelatedUser(User? user) => _relatedUser = user;

  void setToCurrentUser(User? user) => _currentUser = user;

  void addMessage(ChatMessage message) {
    final findMessage =
        _messages.firstWhereOrNull((e) => e.chatMessageUUID == message.chatMessageUUID);
    if (findMessage != null) {
      _messages[_messages.indexWhere((e) => e.chatMessageUUID == message.chatMessageUUID)] =
          ChatMessageModel.fromEntity(findMessage)!.copyWith(messageSent: true);
    } else {
      _messages.add(message);
    }
  }

  void clearMessage() => _messageController.clear();

  void changeEmojiPicker({bool? value}) {
    if (value != null) {
      _showEmojiPicker = value;
      return;
    }
    _showEmojiPicker = !_showEmojiPicker;
  }

  void setPusherChannel(PusherChannelsClient client) {
    _pusherChannelsClient = client;
  }

  void setToSubscription(StreamSubscription<void>? subs) {
    _channelSubscription = subs;
  }

  void disposePusherChannelWithStreamSubscription() async {
    await _pusherChannelsClient?.disconnect();
    await _channelSubscription?.cancel();
    _pusherChannelsClient?.dispose();
    _channelSubscription = null;
    _pusherChannelsClient = null;
  }
}
