import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';

class LoginUsecase {
  final AuthorizationRepo _authorizationRepo;

  LoginUsecase(this._authorizationRepo);

  Future<User?> login({
    required final String emailOrUserName,
    required final String password,
  }) =>
      _authorizationRepo.login(
        emailOrUserName: emailOrUserName,
        password: password,
      );
}
