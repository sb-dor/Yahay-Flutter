import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/room.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';

part 'room_model.freezed.dart';

part 'room_model.g.dart';

@freezed
class RoomModel extends Room with _$RoomModel {
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
