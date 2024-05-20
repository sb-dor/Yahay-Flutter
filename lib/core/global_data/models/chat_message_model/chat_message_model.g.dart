// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      relatedToUser: json['related_to_user'] == null
          ? null
          : UserModel.fromJson(json['related_to_user'] as Map<String, dynamic>),
      chat: json['chat'] == null
          ? null
          : ChatModel.fromJson(json['chat'] as Map<String, dynamic>),
      message: json['message'] as String?,
      chatMessageUUID: json['chat_message_uuid'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      messageSeenAt: json['message_seen_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'related_to_user': instance.relatedToUser,
      'chat': instance.chat,
      'message': instance.message,
      'chat_message_uuid': instance.chatMessageUUID,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'message_seen_at': instance.messageSeenAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
