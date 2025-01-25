import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';

class OtherAuthorizationRepoImpl implements OtherAuthorizationRepo {
  final OtherAuthorizationDatasource _otherAuthorization;

  OtherAuthorizationRepoImpl(this._otherAuthorization);

  @override
  Future<UserModel?> faceBookAuth() => _otherAuthorization.faceBookAuth();

  @override
  Future<UserModel?> googleAuth() => _otherAuthorization.googleAuth();
}
