import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_participant_status.dart';

part 'chat_participant_status_model.freezed.dart';

// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'chat_participant_status_model.g.dart';

@freezed
class ChatParticipantStatusModel extends ChatParticipantStatus with _$ChatParticipantStatusModel {
  const factory ChatParticipantStatusModel({
    int? id,
    String? status,
  }) = _ChatParticipantStatusModel;

  factory ChatParticipantStatusModel.fromJson(Map<String, Object?> json) =>
      _$ChatParticipantStatusModelFromJson(json);

  static ChatParticipantStatusModel? fromEntity(ChatParticipantStatus? status) {
    if (status == null) return null;
    return ChatParticipantStatusModel(
      id: status.id,
      status: status.status,
    );
  }
}
