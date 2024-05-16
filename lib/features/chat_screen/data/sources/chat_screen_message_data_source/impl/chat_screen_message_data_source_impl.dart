import 'dart:io';

import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';

class ChatScreenMessageDataSourceImpl extends ChatScreenMessageDataSource {
  @override
  Future<void> sendMessage({
    required Chat? chat,
    required User? toUser,
    String? message,
  }) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendPicture({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendPicture
    throw UnimplementedError();
  }

  @override
  Future<void> sendVideo({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendVideo
    throw UnimplementedError();
  }
}
