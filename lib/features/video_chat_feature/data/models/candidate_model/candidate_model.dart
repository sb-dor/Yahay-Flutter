import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/features/video_chat_feature/data/models/inner_candidate_model/inner_candidate_model.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/candidate.dart';

part 'candidate_model.freezed.dart';
part 'candidate_model.g.dart';

@freezed
class CandidateModel extends Candidate with _$CandidateModel {
  const factory CandidateModel({
    required int id,
    required int roomId,
    required InnerCandidateModel candidate,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CandidateModel;

  factory CandidateModel.fromJson(Map<String, Object?> json) => _$CandidateModelFromJson(json);
}
