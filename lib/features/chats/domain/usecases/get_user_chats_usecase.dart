import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/features/chats/domain/repo/chats_repo.dart';

class GetUserChatsUseCase {
  final ChatsRepo _chatsRepo;

  GetUserChatsUseCase(this._chatsRepo);

  Future<List<Chat>> chats() => _chatsRepo.chats();
}
