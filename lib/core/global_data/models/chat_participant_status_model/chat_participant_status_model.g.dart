// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_participant_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatParticipantStatusModelImpl _$$ChatParticipantStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatParticipantStatusModelImpl(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$ChatParticipantStatusModelImplToJson(
        _$ChatParticipantStatusModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };
