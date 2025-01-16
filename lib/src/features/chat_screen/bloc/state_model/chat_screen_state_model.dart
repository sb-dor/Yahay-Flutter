import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_functions.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';

class ChatScreenStateModel {
  final List<ChatMessage> messages;
  final StreamSubscription<void>? channelSubscription;
  final PusherChannelsClient? pusherChannelsClient;
  final Chat? currentChat;
  final File? pickedFile;
  final User? currentUser, relatedUser;
  final bool showEmojiPicker;

  const ChatScreenStateModel({
    this.messages = const [],
    this.channelSubscription,
    this.pusherChannelsClient,
    this.currentChat,
    this.pickedFile,
    this.currentUser,
    this.relatedUser,
    this.showEmojiPicker = false,
  });

  ChatModel? get currentChatModel => ChatModel.fromEntity(currentChat);

  ChatFunctions? get currentChatFunctions => ChatFunctions.fromEntity(currentChat);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatScreenStateModel &&
          runtimeType == other.runtimeType &&
          messages == other.messages &&
          channelSubscription == other.channelSubscription &&
          pusherChannelsClient == other.pusherChannelsClient &&
          currentChat == other.currentChat &&
          pickedFile == other.pickedFile &&
          currentUser == other.currentUser &&
          relatedUser == other.relatedUser &&
          showEmojiPicker == other.showEmojiPicker);

  @override
  int get hashCode =>
      messages.hashCode ^
      channelSubscription.hashCode ^
      pusherChannelsClient.hashCode ^
      currentChat.hashCode ^
      pickedFile.hashCode ^
      currentUser.hashCode ^
      relatedUser.hashCode ^
      showEmojiPicker.hashCode;

  @override
  String toString() {
    return 'ChatScreenStateModel{' +
        ' messages: $messages,' +
        ' channelSubscription: $channelSubscription,' +
        ' pusherChannelsClient: $pusherChannelsClient,' +
        ' currentChat: $currentChat,' +
        ' pickedFile: $pickedFile,' +
        ' currentUser: $currentUser,' +
        ' relatedUser: $relatedUser,' +
        ' showEmojiPicker: $showEmojiPicker,' +
        '}';
  }

  ChatScreenStateModel copyWith({
    List<ChatMessage>? messages,
    StreamSubscription<void>? channelSubscription,
    PusherChannelsClient? pusherChannelsClient,
    Chat? currentChat,
    File? pickedFile,
    User? currentUser,
    User? relatedUser,
    bool? showEmojiPicker,
  }) {
    return ChatScreenStateModel(
      messages: messages ?? this.messages,
      channelSubscription: channelSubscription ?? this.channelSubscription,
      pusherChannelsClient: pusherChannelsClient ?? this.pusherChannelsClient,
      currentChat: currentChat ?? this.currentChat,
      pickedFile: pickedFile ?? this.pickedFile,
      currentUser: currentUser ?? this.currentUser,
      relatedUser: relatedUser ?? this.relatedUser,
      showEmojiPicker: showEmojiPicker ?? this.showEmojiPicker,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messages': messages,
      'channelSubscription': channelSubscription,
      'pusherChannelsClient': pusherChannelsClient,
      'currentChat': currentChat,
      'pickedFile': pickedFile,
      'currentUser': currentUser,
      'relatedUser': relatedUser,
      'showEmojiPicker': showEmojiPicker,
    };
  }

  factory ChatScreenStateModel.fromMap(Map<String, dynamic> map) {
    return ChatScreenStateModel(
      messages: map['messages'] as List<ChatMessage>,
      channelSubscription: map['channelSubscription'] as StreamSubscription<void>,
      pusherChannelsClient: map['pusherChannelsClient'] as PusherChannelsClient,
      currentChat: map['currentChat'] as Chat,
      pickedFile: map['pickedFile'] as File,
      currentUser: map['currentUser'] as User,
      relatedUser: map['relatedUser'] as User,
      showEmojiPicker: map['showEmojiPicker'] as bool,
    );
  }
}
