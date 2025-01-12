import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';

class ChatScreenChatRepoImpl implements ChatScreenChatRepo {
  //
  final ChatScreenChatDataSource _chatScreenChatDataSource;

  ChatScreenChatRepoImpl(this._chatScreenChatDataSource);

  @override
  Future<Chat?> chat({Chat? chat, User? withUser}) => _chatScreenChatDataSource.chat(
        chat: chat,
        withUser: withUser,
      );

  @override
  Future<void> removeAllTempCreatedChats({required Chat? chat}) =>
      _chatScreenChatDataSource.removeAllTempCreatedChats(chat: chat);
}
