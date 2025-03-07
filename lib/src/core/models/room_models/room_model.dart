import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';

part 'room_model.freezed.dart';

part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  factory RoomModel({
    final int? id,
    final int? chatId,
    final ChatModel? chat, // model if it will be needed
    final String? offer,
    final String? answer,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, Object?> json) => _$RoomModelFromJson(json);
}
