import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

class ChatScreenStateModel {
  final TextEditingController _messageController = TextEditingController();

  TextEditingController get messageController => _messageController;

  Chat? _currentChat;

  Chat? get currentChat => _currentChat;

  File? _pickedFile;

  File? get pickedFile => _pickedFile;

  User? _relatedUser;

  User? get relatedUser => _relatedUser;

  void setChat(Chat? chat) => _currentChat = chat;

  void setToFile(File? file) => _pickedFile = file;

  void setToRelatedUser(User? user) => _relatedUser = user;
}
