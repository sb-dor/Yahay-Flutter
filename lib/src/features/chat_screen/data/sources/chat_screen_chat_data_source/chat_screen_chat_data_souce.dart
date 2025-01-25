import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract class ChatScreenChatDataSource {
  Future<ChatModel?> chat({ChatModel? chat, UserModel? withUser});

  Future<void> removeAllTempCreatedChats({required ChatModel? chat});
}
