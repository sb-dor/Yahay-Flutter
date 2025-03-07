import 'dart:io';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';

class ChatScreenRepoImpl implements ChatScreenRepo {
  //
  final ChatScreenMessageDataSource _chatScreenMessageDataSource;

  ChatScreenRepoImpl(this._chatScreenMessageDataSource);

  @override
  Future<void> sendMessage({required ChatMessageModel chatMessage}) =>
      _chatScreenMessageDataSource.sendMessage(chatMessage: chatMessage);

  @override
  Future<void> sendPicture({
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  }) => _chatScreenMessageDataSource.sendPicture(
    chat: chat,
    toUser: toUser,
    file: file,
    message: message,
  );

  @override
  Future<void> sendVideo({
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  }) => _chatScreenMessageDataSource.sendVideo(
    chat: chat,
    toUser: toUser,
    file: file,
    message: message,
  );
}
