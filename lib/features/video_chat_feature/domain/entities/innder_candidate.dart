import 'package:flutter/foundation.dart';

@immutable
class InnerCandidate {
  final String? candidate;
  final String? sdpMid;
  final int? sdpMLineIndex;

  const InnerCandidate({
    required this.candidate,
    required this.sdpMid,
    required this.sdpMLineIndex,
  });
}
