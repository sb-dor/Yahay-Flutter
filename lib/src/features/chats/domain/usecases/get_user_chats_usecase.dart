import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';

class GetUserChatsUseCase {
  final ChatsRepo _chatsRepo;

  GetUserChatsUseCase(this._chatsRepo);

  Future<List<ChatModel>> chats() => _chatsRepo.chats();
}
