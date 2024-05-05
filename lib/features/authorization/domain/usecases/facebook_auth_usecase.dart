import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/authorization/domain/repo/other_authorization_repo.dart';

class FacebookAuthUsecase {
  final OtherAuthorizationRepo _otherAuthorizationRepo;

  FacebookAuthUsecase(this._otherAuthorizationRepo);

  Future<User?> facebookAuth() => _otherAuthorizationRepo.faceBookAuth();
}
