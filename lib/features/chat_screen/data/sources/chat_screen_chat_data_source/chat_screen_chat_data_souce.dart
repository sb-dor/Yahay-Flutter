import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';

abstract class ChatScreenChatDataSource {
  Future<ChatModel?> chat();
}
