// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/core/global_data/entities/user.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel extends User with _$UserModel {
  factory UserModel({
    int? id,
    String? name,
    String? email,
    @JsonKey(name: "user_name") String? userName,
    @JsonKey(name: "birth_day") String? birthDay,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool? loadingForAddingToContacts,
    @JsonKey(name: "user_contact") UserModel? contact,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  static UserModel? fromEntity(User? user) {
    if (user == null) return null;
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      userName: user.userName,
      birthDay: user.birthDay,
      imageUrl: user.imageUrl,
      createdAt: user.createdAt,
      loadingForAddingToContacts: user.loadingForAddingToContacts,
      contact: user.contact == null ? null : UserModel.fromEntity(user.contact),
    );
  }
}
