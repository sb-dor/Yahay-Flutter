import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvents {}

@immutable
class RegisterEvent extends AuthEvents {
  final String email;
  final String password;
  final String userName;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.userName,
  });
}

@immutable
class LoginEvent extends AuthEvents {
  final String emailOrUserName;
  final String password;

  LoginEvent({required this.emailOrUserName, required this.password});
}

@immutable
class CheckAuthEvent extends AuthEvents {}

@immutable
class ChangePasswordVisibility extends AuthEvents {}
