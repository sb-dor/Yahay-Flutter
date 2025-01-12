// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/src/core/global_data/models/chat_participant_status_model/chat_participant_status_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_data/models/user_model/user_model.dart';

part 'chat_participant_model.freezed.dart';

part 'chat_participant_model.g.dart';

@freezed
class ChatParticipantModel extends ChatParticipant with _$ChatParticipantModel {
  const factory ChatParticipantModel({
    final int? id,
    final UserModel? user,
    final ChatModel? chat,
    final ChatParticipantStatusModel? status,
    final bool? muted,
    @JsonKey(name: "participated_at") final String? participateAt,
  }) = _ChatParticipantModel;

  factory ChatParticipantModel.fromJson(Map<String, Object?> json) =>
      _$ChatParticipantModelFromJson(json);

  static ChatParticipantModel? fromEntity(ChatParticipant? chatParticipant) {
    if (chatParticipant == null) return null;
    return ChatParticipantModel(
      id: chatParticipant.id,
      user: UserModel.fromEntity(chatParticipant.user),
      chat: ChatModel.fromEntity(chatParticipant.chat),
      status: ChatParticipantStatusModel.fromEntity(chatParticipant.status),
      muted: chatParticipant.muted,
      participateAt: chatParticipant.participateAt,
    );
  }
}
