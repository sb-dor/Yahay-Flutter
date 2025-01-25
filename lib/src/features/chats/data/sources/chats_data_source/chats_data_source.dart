import 'package:yahay/src/core/models/chats_model/chat_model.dart';

abstract class ChatsDataSource {
  Future<List<ChatModel>> chats();
}
