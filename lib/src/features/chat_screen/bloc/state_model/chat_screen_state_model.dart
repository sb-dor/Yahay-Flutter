import 'dart:io';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

class ChatScreenStateModel {
  final List<ChatMessageModel> messages;
  final ChatModel? currentChat;
  final File? pickedFile;
  final UserModel? currentUser, relatedUser;
  final bool showEmojiPicker;

  const ChatScreenStateModel({
    this.messages = const [],
    this.currentChat,
    this.pickedFile,
    this.currentUser,
    this.relatedUser,
    this.showEmojiPicker = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatScreenStateModel &&
          runtimeType == other.runtimeType &&
          messages == other.messages &&
          // channelSubscription == other.channelSubscription &&
          // pusherChannelsClient == other.pusherChannelsClient &&
          currentChat == other.currentChat &&
          pickedFile == other.pickedFile &&
          currentUser == other.currentUser &&
          relatedUser == other.relatedUser &&
          showEmojiPicker == other.showEmojiPicker);

  @override
  int get hashCode =>
      messages.hashCode ^
      // pusherChannelsClient.hashCode ^
      currentChat.hashCode ^
      pickedFile.hashCode ^
      currentUser.hashCode ^
      relatedUser.hashCode ^
      showEmojiPicker.hashCode;

  @override
  String toString() {
    return 'ChatScreenStateModel{'
            ' messages: $messages,'
            ' currentChat: $currentChat,'
            ' pickedFile: $pickedFile,'
            ' currentUser: $currentUser,' ' relatedUser: $relatedUser,' ' showEmojiPicker: $showEmojiPicker,' '}';
  }

  ChatScreenStateModel copyWith({
    List<ChatMessageModel>? messages,
    // PusherChannelsClient? pusherChannelsClient,
    ChatModel? currentChat,
    File? pickedFile,
    UserModel? currentUser,
    UserModel? relatedUser,
    bool? showEmojiPicker,
  }) {
    return ChatScreenStateModel(
      messages: messages ?? this.messages,
      // pusherChannelsClient: pusherChannelsClient ?? this.pusherChannelsClient,
      currentChat: currentChat ?? this.currentChat,
      pickedFile: pickedFile ?? this.pickedFile,
      currentUser: currentUser ?? this.currentUser,
      relatedUser: relatedUser ?? this.relatedUser,
      showEmojiPicker: showEmojiPicker ?? this.showEmojiPicker,
    );
  }
}
