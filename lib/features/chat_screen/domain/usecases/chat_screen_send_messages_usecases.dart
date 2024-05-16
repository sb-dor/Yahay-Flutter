import 'dart:io';

import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';

class ChatScreenSendMessagesUsecases {
  final ChatScreenRepo _chatScreenRepo;

  ChatScreenSendMessagesUsecases(this._chatScreenRepo);

  Future<void> sendMessage({required Chat? chat, required User? toUser, String? message}) =>
      _chatScreenRepo.sendMessage(chat: chat, toUser: toUser, message: message);

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
