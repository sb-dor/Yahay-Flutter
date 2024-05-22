import 'package:flutter/foundation.dart';
import 'package:yahay/features/authorization/domain/repo/authorization_repo.dart';

@immutable
class LogoutUsecase {
  final AuthorizationRepo _authorizationRepo;

  const LogoutUsecase(this._authorizationRepo);

  Future<bool> logout() => _authorizationRepo.logout();
}
