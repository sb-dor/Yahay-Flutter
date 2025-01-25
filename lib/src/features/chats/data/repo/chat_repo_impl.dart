import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';

class ChatsRepoImpl extends ChatsRepo {
  final ChatsDataSource _chatsDataSource;

  ChatsRepoImpl(this._chatsDataSource);

  @override
  Future<List<ChatModel>> chats() => _chatsDataSource.chats();
}
