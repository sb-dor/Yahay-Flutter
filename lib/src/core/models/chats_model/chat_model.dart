// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/src/core/models/room_models/room_model.dart';

part 'chat_model.freezed.dart';

part 'chat_model.g.dart';

bool? _fromJsonVideoChatStreaming(dynamic json) {
  if (json is int) {
    return json == 1;
  }
  return json as bool?;
}

@freezed
class ChatModel with _$ChatModel {
  const ChatModel._();

  const factory ChatModel({
    int? id,
    @JsonKey(name: "chat_uuid") String? uuid,
    String? name,
    String? description,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,

    //
    @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
    @JsonKey(name: "participants") List<ChatParticipantModel>? participants,
    @JsonKey(name: "messages") List<ChatMessageModel>? messages,
    @JsonKey(name: "chat_video_room") RoomModel? videoChatRoom,
    @JsonKey(
      name: "video_chat_streaming",
      includeFromJson: true,
      includeToJson: false,
      defaultValue: false,
      fromJson: _fromJsonVideoChatStreaming,
    )
    bool? videoChatStreaming,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);

  String getWrappedName() {
    if (name == null) return '';
    if ((name ?? '').isEmpty) return '';
    if ((name?.length ?? 0) < 1) return name?[0] ?? '';
    return "${name?[0].toUpperCase()} ${name?[(name?.length ?? 0) - 1].toUpperCase()}";
  }

  String channelName() {
    return "${Constants.chatChannelName}$id${Constants.chatChannelUUID}$uuid";
  }
}
