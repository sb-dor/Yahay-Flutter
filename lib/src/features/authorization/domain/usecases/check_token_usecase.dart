import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';

class CheckTokenUseCase {
  final AuthorizationRepo _authorizationRepo;

  CheckTokenUseCase(this._authorizationRepo);

  Future<User?> checkAuth() => _authorizationRepo.checkAuth();
}
