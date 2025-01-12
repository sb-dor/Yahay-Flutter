import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';

class GoogleAuthUsecase {
  final OtherAuthorizationRepo _otherAuthorizationRepo;

  GoogleAuthUsecase(this._otherAuthorizationRepo);

  Future<User?> googleAuth() => _otherAuthorizationRepo.googleAuth();
}
