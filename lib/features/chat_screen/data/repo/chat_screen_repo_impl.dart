import 'dart:io';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';

class ChatScreenRepoImpl implements ChatScreenRepo {
  //
  final ChatScreenMessageDataSource _chatScreenMessageDataSource;

  ChatScreenRepoImpl(this._chatScreenMessageDataSource);

  @override
  Future<void> sendMessage({required ChatMessage chatMessage}) =>
      _chatScreenMessageDataSource.sendMessage(chatMessage: chatMessage);

  @override
  Future<void> sendPicture({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) =>
      _chatScreenMessageDataSource.sendPicture(
        chat: chat,
        toUser: toUser,
        file: file,
        message: message,
      );

  @override
  Future<void> sendVideo({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) =>
      _chatScreenMessageDataSource.sendVideo(
        chat: chat,
        toUser: toUser,
        file: file,
        message: message,
      );
}
