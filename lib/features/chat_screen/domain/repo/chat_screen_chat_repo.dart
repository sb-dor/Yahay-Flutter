import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

abstract class ChatScreenChatRepo {
  // create or get existing chat
  Future<Chat?> chat({Chat? chat, User? withUser});

  Future<void> removeAllTempCreatedChats();
}
