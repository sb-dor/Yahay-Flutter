import 'dart:io';

import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract class ChatScreenRepo {
  Future<void> sendMessage({
    required ChatMessageModel chatMessage,
  });

  Future<void> sendPicture({
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  });

  Future<void> sendVideo({
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  });
}
