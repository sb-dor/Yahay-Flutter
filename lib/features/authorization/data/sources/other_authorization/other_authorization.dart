import 'package:yahay/core/global_data/models/user_model/user_model.dart';

abstract class OtherAuthorization {
  Future<UserModel?> googleAuth();

  Future<UserModel?> faceBookAuth();
}
