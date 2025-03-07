import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';

class AuthorizationRepoImpl implements AuthorizationRepo {
  final LaravelAuthDataSource _laravelAuthDataSource;

  AuthorizationRepoImpl(this._laravelAuthDataSource);

  @override
  Future<UserModel?> checkAuth() => _laravelAuthDataSource.checkAuth();

  @override
  Future<UserModel?> login({
    required final String emailOrUserName,
    required final String password,
  }) => _laravelAuthDataSource.login(
    emailOrUserName: emailOrUserName,
    password: password,
  );

  @override
  Future<UserModel?> register({
    required final String email,
    required final String password,
    required final String userName,
  }) => _laravelAuthDataSource.register(
    email: email,
    password: password,
    userName: userName,
  );

  @override
  Future<bool> logout() => _laravelAuthDataSource.logout();
}
