import 'package:flutter/foundation.dart';

@immutable
class ChatParticipantStatus {
  final int? id;
  final String? status;

  const ChatParticipantStatus({required this.id, required this.status});
}
