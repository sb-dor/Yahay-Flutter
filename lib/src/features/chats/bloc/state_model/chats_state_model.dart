import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';

class ChatsStateModel {
  final List<Chat> chats;

  const ChatsStateModel({
    required this.chats,
  });

  factory ChatsStateModel.idle() => const ChatsStateModel(chats: <Chat>[]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatsStateModel && runtimeType == other.runtimeType && chats == other.chats);

  @override
  int get hashCode => chats.hashCode;

  @override
  String toString() {
    return 'ChatsStateModel{' + ' chats: $chats,' + '}';
  }

  ChatsStateModel copyWith({
    List<Chat>? chats,
  }) {
    return ChatsStateModel(
      chats: chats ?? this.chats,
    );
  }
}
