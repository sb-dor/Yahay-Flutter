import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';

abstract class ChatScreenChatDataSource {
  Future<ChatModel?> chat({Chat? chat, User? withUser});

  Future<void> removeAllTempCreatedChats();
}
