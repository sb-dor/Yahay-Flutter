// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatParticipantModelImpl _$$ChatParticipantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatParticipantModelImpl(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      chat: json['chat'] == null
          ? null
          : ChatModel.fromJson(json['chat'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : ChatParticipantStatusModel.fromJson(
              json['status'] as Map<String, dynamic>),
      muted: json['muted'] as bool?,
      participateAt: json['participated_at'] as String?,
    );

Map<String, dynamic> _$$ChatParticipantModelImplToJson(
        _$ChatParticipantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'chat': instance.chat,
      'status': instance.status,
      'muted': instance.muted,
      'participated_at': instance.participateAt,
    };
