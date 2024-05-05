import 'package:yahay/core/global_data/entities/user.dart';

class AuthStateModel {
  User? _user;

  User? get user => _user;

  bool _showPassword = true;

  bool get showPassword => _showPassword;

  void setUser(User? user) => _user = user;

  void changePasswordVisibility() => _showPassword = !_showPassword;
}
