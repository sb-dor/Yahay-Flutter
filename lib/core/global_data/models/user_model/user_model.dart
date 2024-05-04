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
    String? userName,
    String? birthDay,
    String? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        userName: user.userName,
        birthDay: user.birthDay,
        createdAt: user.createdAt,
      );
}
