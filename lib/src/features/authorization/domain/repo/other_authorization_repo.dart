import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract class OtherAuthorizationRepo {
  Future<UserModel?> googleAuth();

  Future<UserModel?> faceBookAuth();
}
