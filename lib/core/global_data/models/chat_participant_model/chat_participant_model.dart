import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/core/global_data/models/chat_participant_status_model/chat_participant_status_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';

part 'chat_participant_model.freezed.dart';

part 'chat_participant_model.g.dart';

@freezed
class ChatParticipantModel extends ChatParticipant with _$ChatParticipantModel {
  const factory ChatParticipantModel({
    final int? id,
    final UserModel? user,
    final ChatParticipantStatusModel? status,
    final bool? muted,
    final String? participateAt,
  }) = _ChatParticipantModel;

  factory ChatParticipantModel.fromJson(Map<String, Object?> json) =>
      _$ChatParticipantModelFromJson(json);

  factory ChatParticipantModel.fromEntity(ChatParticipant? chatParticipant){
    return ChatParticipantModel(
      id: chatParticipant?.id,
      user: UserModel.fromEntity(chatParticipant?.user),
      status: ChatParticipantStatusModel.fromEntity(chatParticipant?.status),
      muted: chatParticipant?.muted,
      participateAt: chatParticipant?.participateAt,
    );
  }
}
