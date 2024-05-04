import 'package:yahay/core/global_data/models/user_model/user_model.dart';

abstract class LaravelAuthDataSource {
  Future<UserModel?> register({
    required final String email,
    required final String password,
    required final String userName,
  });

  Future<UserModel?> login({
    required final String emailOrUserName,
    required final String password,
  });

  Future<UserModel?> checkAuth();
}
