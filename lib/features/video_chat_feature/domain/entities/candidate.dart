import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/innder_candidate.dart';

@immutable
class Candidate {
  final int id;
  final int roomId;
  final InnerCandidate candidate;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Candidate({
    required this.id,
    required this.roomId,
    required this.candidate,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
}
