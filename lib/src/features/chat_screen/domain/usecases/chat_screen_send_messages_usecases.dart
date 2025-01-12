import 'dart:io';

import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';

class ChatScreenSendMessagesUsecases {
  final ChatScreenRepo _chatScreenRepo;

  ChatScreenSendMessagesUsecases(this._chatScreenRepo);

  Future<void> sendMessage({required ChatMessage chatMessage}) =>
      _chatScreenRepo.sendMessage(chatMessage: chatMessage);

  Future<void> sendPicture({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) =>
      _chatScreenRepo.sendPicture(
        chat: chat,
        toUser: toUser,
        file: file,
        message: message,
      );

  Future<void> sendVideo({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) =>
      _chatScreenRepo.sendVideo(
        chat: chat,
        toUser: toUser,
        file: file,
        message: message,
      );
}
