// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  factory UserModel({
    int? id,
    String? name,
    String? email,
    @JsonKey(name: "user_name") String? userName,
    @JsonKey(name: "birth_day") String? birthDay,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false) @Default(
        false) bool? loadingForAddingToContacts,
    @JsonKey(name: "user_contact") UserModel? contact,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  String getFirstAndLastLetterOfName() {
    if ((name ?? '').isEmpty) return "";
    if ((name ?? '').length <= 2) return name?[0] ?? '';
    return "${name?[0]}${name?[(name ?? '').length - 1]}".toUpperCase();
  }
}
