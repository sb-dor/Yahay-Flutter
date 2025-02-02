import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract class AuthorizationRepo {
  Future<UserModel?> register({
    required final String email,
    required final String password,
    required final String userName,
  });

  Future<UserModel?> login({
    required final String emailOrUserName,
    required final String password,
  });

  Future<UserModel?> checkAuth({
    required void Function(String message) onMessage,
  });

  Future<bool> logout();
}
