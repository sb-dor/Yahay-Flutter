import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';

abstract class ChatScreenChatRepo {
  // create or get existing chat
  Future<Chat?> chat();
}
