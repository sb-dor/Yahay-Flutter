import 'package:yahay/core/global_data/entities/chat.dart';

abstract class ChatsRepo {
  Future<List<Chat>> chats();
}
