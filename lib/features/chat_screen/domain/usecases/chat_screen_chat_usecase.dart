import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';

class ChatScreenChatUsecase {
  final ChatScreenChatRepo _chatScreenChatRepo;

  ChatScreenChatUsecase(this._chatScreenChatRepo);

  Future<Chat?> chat() => _chatScreenChatRepo.chat();
}
