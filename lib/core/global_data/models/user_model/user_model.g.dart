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
      userName: json['userName'] as String?,
      birthDay: json['birthDay'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      loadingForAddingToContacts:
          json['loadingForAddingToContacts'] as bool? ?? false,
      contact: json['user_contact'] == null
          ? null
          : UserModel.fromJson(json['user_contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'userName': instance.userName,
      'birthDay': instance.birthDay,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'loadingForAddingToContacts': instance.loadingForAddingToContacts,
      'user_contact': instance.contact,
    };
