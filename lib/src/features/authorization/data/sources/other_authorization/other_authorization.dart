import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract interface class OtherAuthorizationDatasource {
  Future<UserModel?> googleAuth();

  Future<UserModel?> faceBookAuth();
}
