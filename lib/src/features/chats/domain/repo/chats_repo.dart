import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';

abstract class ChatsRepo {
  Future<List<Chat>> chats();
}
