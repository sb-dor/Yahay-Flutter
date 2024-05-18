// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
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
      chatMessageUUID: json['chatMessageUUID'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      messageSent: json['messageSent'] as bool?,
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'related_to_user': instance.relatedToUser,
      'chat': instance.chat,
      'message': instance.message,
      'chatMessageUUID': instance.chatMessageUUID,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
      'messageSent': instance.messageSent,
    };
