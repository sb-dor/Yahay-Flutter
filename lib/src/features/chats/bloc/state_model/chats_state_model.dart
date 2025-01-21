import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';

class ChatsStateModel {


  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  // void setToPusherClient(PusherChannelsClient? client) {
  //   _pusherClientService = client;
  // }
  //
  // void setToSubscription(StreamSubscription<void>? subs) {
  //   _channelSubscription = subs;
  // }
  //
  // Future<void> disposeClientAndSubs() async {
  //   await _pusherClientService?.disconnect();
  //   await _channelSubscription?.cancel();
  //   _pusherClientService?.dispose();
  //   _pusherClientService = null;
  //   _channelSubscription = null;
  // }

  void setChat(List<Chat> list) => _chats = list;

  void clearChat() => _chats.clear();

  void addChat(Chat chat, User? user) {
    var convertedToModelChat = ChatModel.fromEntity(chat);

    if (convertedToModelChat == null) return;

    convertedToModelChat = _removeCurrentUserFromParticipants(
      convertedToModelChat,
      user,
    );

    final findChat = _chats.firstWhereOrNull(
      (e) => e.id == convertedToModelChat?.id && e.uuid == convertedToModelChat?.uuid,
    );

    if (findChat != null) {
      _chats[_chats.indexWhere(
        (e) => e.id == convertedToModelChat?.id && e.uuid == convertedToModelChat?.uuid,
      )] = convertedToModelChat.copyWith(
        lastMessage: ChatMessageModel.fromEntity(chat.lastMessage),
      );
    } else {
      _chats.add(convertedToModelChat);
    }
  }

  ChatModel _removeCurrentUserFromParticipants(ChatModel chatModel, User? user) {
    final data = List<ChatParticipantModel>.from(chatModel.participants ?? <ChatParticipant>[]);

    data.removeWhere((e) => e.user?.id == user?.id);

    chatModel = chatModel.copyWith(participants: data);

    return chatModel;
  }

  // Future<void> clearAll() async {
  //   await disposeClientAndSubs();
  //   _chats.clear();
  // }
}
