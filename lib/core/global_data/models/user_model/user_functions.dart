import 'package:yahay/core/global_data/entities/user.dart';

class UserFunctions extends User {
  const UserFunctions({
    super.id,
    super.name,
    super.email,
    super.userName,
    super.birthDay,
    super.imageUrl,
    super.createdAt,
  });

  factory UserFunctions.fromEntity(User user) => UserFunctions(
        id: user.id,
        name: user.name,
        email: user.email,
        userName: user.userName,
        birthDay: user.birthDay,
        imageUrl: user.imageUrl,
        createdAt: user.createdAt,
      );

  String getFirstAndLastLetterOfName() {
    if ((name ?? '').isEmpty) return "";
    if ((name ?? '').length <= 2) return name?[0] ?? '';
    return "${name?[0]}${name?[(name ?? '').length - 1]}".toUpperCase();
  }
}
