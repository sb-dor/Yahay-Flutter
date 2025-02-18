import 'package:yahay/src/core/models/user_model/user_model.dart';

class ProfileStateModel {
  final UserModel? userModel;

  const ProfileStateModel({
    this.userModel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileStateModel &&
          runtimeType == other.runtimeType &&
          userModel == other.userModel);

  @override
  int get hashCode => userModel.hashCode;

  @override
  String toString() {
    return 'ProfileStateModel{' ' userModel: $userModel,' '}';
  }

  ProfileStateModel copyWith({
    UserModel? userModel,
  }) {
    return ProfileStateModel(
      userModel: userModel ?? this.userModel,
    );
  }
}
