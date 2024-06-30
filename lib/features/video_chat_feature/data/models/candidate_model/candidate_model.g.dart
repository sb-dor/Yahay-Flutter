// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CandidateModelImpl _$$CandidateModelImplFromJson(Map<String, dynamic> json) =>
    _$CandidateModelImpl(
      id: (json['id'] as num).toInt(),
      roomId: (json['roomId'] as num).toInt(),
      candidate: InnerCandidateModel.fromJson(
          json['candidate'] as Map<String, dynamic>),
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CandidateModelImplToJson(
        _$CandidateModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'candidate': instance.candidate,
      'role': instance.role,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
