import 'package:yahay/core/global_data/entities/user.dart';

abstract class AuthorizationRepo {
  Future<User?> register({
    required final String email,
    required final String password,
    required final String userName,
  });

  Future<User?> login({
    required final String emailOrUserName,
    required final String password,
  });

  Future<User?> checkAuth();
}
