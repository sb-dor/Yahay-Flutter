import 'package:yahay/src/core/global_data/entities/user.dart';

abstract class OtherAuthorizationRepo {
  Future<User?> googleAuth();

  Future<User?> faceBookAuth();
}
