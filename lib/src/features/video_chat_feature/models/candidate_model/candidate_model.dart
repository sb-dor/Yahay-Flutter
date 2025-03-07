import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/features/video_chat_feature/models/inner_candidate_model/inner_candidate_model.dart';

part 'candidate_model.freezed.dart';

part 'candidate_model.g.dart';

InnerCandidateModel? _fromJsonInnerCandidate(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, Object>) {
    return InnerCandidateModel.fromJson(json);
  } else if (json is String) {
    final parsedJson = jsonDecode(json);
    return InnerCandidateModel.fromJson(parsedJson);
  } else {
    return null;
  }
}

@freezed
class CandidateModel with _$CandidateModel {
  const factory CandidateModel({
    required int? id,
    @JsonKey(name: "room_id") required int? roomId,
    @JsonKey(fromJson: _fromJsonInnerCandidate)
    required InnerCandidateModel? candidate,
    required String? role,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _CandidateModel;

  factory CandidateModel.fromJson(Map<String, Object?> json) =>
      _$CandidateModelFromJson(json);
}
