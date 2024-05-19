import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';

class ChatScreenStateModel {
  final TextEditingController _messageController = TextEditingController();

  TextEditingController get messageController => _messageController;

  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  Chat? _currentChat;

  Chat? get currentChat => _currentChat;

  File? _pickedFile;

  File? get pickedFile => _pickedFile;

  User? _currentUser, _relatedUser;

  User? get relatedUser => _relatedUser;

  User? get currentUser => _currentUser;

  void setChat(Chat? chat) {
    if (chat == null) return;
    _currentChat = chat;
    _messages.addAll((chat.messages ?? []).reversed.toList());
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
}
