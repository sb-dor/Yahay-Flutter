// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inner_candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InnerCandidateModelImpl _$$InnerCandidateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InnerCandidateModelImpl(
      candidate: json['candidate'] as String?,
      sdpMid: json['sdpMid'] as String?,
      sdpMLineIndex: (json['sdpMLineIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InnerCandidateModelImplToJson(
        _$InnerCandidateModelImpl instance) =>
    <String, dynamic>{
      'candidate': instance.candidate,
      'sdpMid': instance.sdpMid,
      'sdpMLineIndex': instance.sdpMLineIndex,
    };
