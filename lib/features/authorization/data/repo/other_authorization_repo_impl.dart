import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/features/authorization/domain/repo/other_authorization_repo.dart';

class OtherAuthorizationRepoImpl implements OtherAuthorizationRepo {
  final OtherAuthorization _otherAuthorization;

  OtherAuthorizationRepoImpl(this._otherAuthorization);

  @override
  Future<User?> faceBookAuth() => _otherAuthorization.faceBookAuth();

  @override
  Future<User?> googleAuth() => _otherAuthorization.googleAuth();
}
