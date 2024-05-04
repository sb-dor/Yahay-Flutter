import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/authorization/domain/repo/authorization_repo.dart';

class RegisterUsecase {
  final AuthorizationRepo _authorizationRepo;

  RegisterUsecase(this._authorizationRepo);

  Future<User?> register({
    required final String email,
    required final String password,
    required final String userName,
  }) =>
      _authorizationRepo.register(
        email: email,
        password: password,
        userName: userName,
      );
}
