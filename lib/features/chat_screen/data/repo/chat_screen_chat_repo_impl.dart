import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';

class ChatScreenChatRepoImpl implements ChatScreenChatRepo {
  //
  final ChatScreenChatDataSource _chatScreenChatDataSource;

  ChatScreenChatRepoImpl(this._chatScreenChatDataSource);

  @override
  Future<Chat?> chat() => _chatScreenChatDataSource.chat();
}
