import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvents {}

@immutable
class GoogleAuth extends AuthEvents {
  final void Function() initChatsBloc;

  GoogleAuth({required this.initChatsBloc});
}

@immutable
class FacebookAuth extends AuthEvents {
  final void Function() initChatsBloc;

  FacebookAuth({required this.initChatsBloc});
}

@immutable
class RegisterEvent extends AuthEvents {
  final String email;
  final String password;
  final String userName;
  final void Function() initChatsBloc;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.userName,
    required this.initChatsBloc,
  });
}

@immutable
class LoginEvent extends AuthEvents {
  final String emailOrUserName;
  final String password;
  final void Function() initChatsBloc;

  LoginEvent({
    required this.emailOrUserName,
    required this.password,
    required this.initChatsBloc,
  });
}

@immutable
class CheckAuthEvent extends AuthEvents {
  final void Function() initChatsBloc;

  CheckAuthEvent({required this.initChatsBloc});
}

@immutable
class ChangePasswordVisibility extends AuthEvents {}

@immutable
class LogOutEvent extends AuthEvents {}
