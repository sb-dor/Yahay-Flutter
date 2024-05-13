import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';

class ChatScreenStateModel {
  Chat? _currentChat;

  Chat? get currentChat => _currentChat;

  void setChat(Chat? chat) => _currentChat = chat;
}
