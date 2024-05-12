import 'dart:io';

import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';

class ChatScreenSendMessagesUsecases {
  final ChatScreenRepo _chatScreenRepo;

  ChatScreenSendMessagesUsecases(this._chatScreenRepo);

  Future<void> sendMessage({required User toUser, String? message}) =>
      _chatScreenRepo.sendMessage(toUser: toUser, message: message);

  Future<void> sendPicture({required User toUser, required File file, String? message}) =>
      _chatScreenRepo.sendPicture(toUser: toUser, file: file, message: message);

  Future<void> sendVideo({required User toUser, required File file, String? message}) =>
      _chatScreenRepo.sendVideo(toUser: toUser, file: file, message: message);
}
