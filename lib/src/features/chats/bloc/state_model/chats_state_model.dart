import 'package:yahay/src/core/models/chats_model/chat_model.dart';

class ChatsStateModel {
  final List<ChatModel> chats;

  const ChatsStateModel({required this.chats});

  factory ChatsStateModel.idle() => const ChatsStateModel(chats: <ChatModel>[]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatsStateModel && runtimeType == other.runtimeType && chats == other.chats);

  @override
  int get hashCode => chats.hashCode;

  @override
  String toString() {
    return 'ChatsStateModel{'
        ' chats: $chats,'
        '}';
  }

  ChatsStateModel copyWith({List<ChatModel>? chats}) {
    return ChatsStateModel(chats: chats ?? this.chats);
  }
}
