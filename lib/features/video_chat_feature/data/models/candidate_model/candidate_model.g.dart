// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CandidateModelImpl _$$CandidateModelImplFromJson(Map<String, dynamic> json) =>
    _$CandidateModelImpl(
      id: (json['id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      candidate: _fromJsonInnerCandidate(json['candidate']),
      role: json['role'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CandidateModelImplToJson(
        _$CandidateModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'candidate': instance.candidate,
      'role': instance.role,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
