// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      userName: json['user_name'] as String?,
      birthDay: json['birth_day'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String?,
      contact: json['user_contact'] == null
          ? null
          : UserModel.fromJson(json['user_contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'user_name': instance.userName,
      'birth_day': instance.birthDay,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt,
      'user_contact': instance.contact,
    };
