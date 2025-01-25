// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/models/chat_participant_status_model/chat_participant_status_model.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

part 'chat_participant_model.freezed.dart';

part 'chat_participant_model.g.dart';

@freezed
class ChatParticipantModel  with _$ChatParticipantModel {
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


}
