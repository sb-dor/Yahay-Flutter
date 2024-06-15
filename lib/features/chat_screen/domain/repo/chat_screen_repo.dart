import 'dart:io';

import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/user.dart';

abstract class ChatScreenRepo {
  Future<void> sendMessage({
    required ChatMessage chatMessage,
  });

  Future<void> sendPicture({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  });

  Future<void> sendVideo({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  });
}
