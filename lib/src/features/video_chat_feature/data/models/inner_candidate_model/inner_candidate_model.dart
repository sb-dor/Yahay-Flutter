import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/features/video_chat_feature/domain/entities/innder_candidate.dart';

part 'inner_candidate_model.freezed.dart';
part 'inner_candidate_model.g.dart';


@freezed
class InnerCandidateModel extends InnerCandidate with _$InnerCandidateModel{
  const factory InnerCandidateModel({
    required String? candidate,
    required String? sdpMid,
    required int? sdpMLineIndex,
  }) = _InnerCandidateModel;

  factory InnerCandidateModel.fromJson(Map<String, Object?> json)
  => _$InnerCandidateModelFromJson(json);
}
