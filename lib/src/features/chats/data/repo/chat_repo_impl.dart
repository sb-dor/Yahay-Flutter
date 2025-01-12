import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';

class ChatsRepoImpl extends ChatsRepo {
  final ChatsDataSource _chatsDataSource;

  ChatsRepoImpl(this._chatsDataSource);

  @override
  Future<List<Chat>> chats() => _chatsDataSource.chats();
}
