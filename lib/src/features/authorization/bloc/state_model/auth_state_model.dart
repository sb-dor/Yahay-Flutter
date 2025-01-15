import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';

class AuthStateModel {

  final User? user;
  final bool showPassword, loadingRegister, loadingLogin;

  const AuthStateModel({

    required this.user,
    required this.showPassword,
    required this.loadingRegister,
    required this.loadingLogin,
  });

  factory AuthStateModel.idle() => AuthStateModel(

        user: null,
        showPassword: true,
        loadingRegister: false,
        loadingLogin: false,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthStateModel &&
          runtimeType == other.runtimeType &&

          user == other.user &&
          showPassword == other.showPassword &&
          loadingRegister == other.loadingRegister &&
          loadingLogin == other.loadingLogin);

  @override
  int get hashCode =>

      user.hashCode ^
      showPassword.hashCode ^
      loadingRegister.hashCode ^
      loadingLogin.hashCode;

  @override
  String toString() {
    return '''AuthStateModel{ 
         user: $user,
         showPassword: $showPassword,
         loadingRegister: $loadingRegister,
         loadingLogin: $loadingLogin,
        '}''';
  }

  AuthStateModel copyWith({
    GlobalKey<FormState>? loginForm,
    GlobalKey<FormState>? registerForm,
    User? user,
    bool? showPassword,
    bool? loadingRegister,
    bool? loadingLogin,

    //
    bool setUserOnNull = false,
  }) {
    return AuthStateModel(
      user: setUserOnNull ? user : user ?? this.user,
      showPassword: showPassword ?? this.showPassword,
      loadingRegister: loadingRegister ?? this.loadingRegister,
      loadingLogin: loadingLogin ?? this.loadingLogin,
    );
  }
}
