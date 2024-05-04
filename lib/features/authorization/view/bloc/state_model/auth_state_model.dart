import 'package:yahay/core/global_data/entities/user.dart';

class AuthStateModel {
  User? _user;

  User? get user => _user;

  void setUser(User? user) => _user = user;
}
