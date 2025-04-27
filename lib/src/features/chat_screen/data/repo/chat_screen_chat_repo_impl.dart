import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';

class ChatScreenChatRepoImpl implements ChatScreenChatRepo {
  //
  final ChatScreenChatDataSource _chatScreenChatDataSource;

  ChatScreenChatRepoImpl(this._chatScreenChatDataSource);

  @override
  Future<ChatModel?> chat({ChatModel? chat, UserModel? withUser}) =>
      _chatScreenChatDataSource.chat(chat: chat, withUser: withUser);

  @override
  Future<void> removeAllTempCreatedChats({required ChatModel? chat}) =>
      _chatScreenChatDataSource.removeAllTempCreatedChats(chat: chat);
}
