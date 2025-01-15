import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';

class AuthStateModel {
  final GlobalKey<FormState> loginForm;
  final GlobalKey<FormState> registerForm;
  final User? user;
  final bool showPassword, loadingRegister, loadingLogin;

  const AuthStateModel({
    required this.loginForm,
    required this.registerForm,
    required this.user,
    required this.showPassword,
    required this.loadingRegister,
    required this.loadingLogin,
  });

  factory AuthStateModel.idle() => AuthStateModel(
        loginForm: GlobalKey<FormState>(),
        registerForm: GlobalKey<FormState>(),
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
          loginForm == other.loginForm &&
          registerForm == other.registerForm &&
          user == other.user &&
          showPassword == other.showPassword &&
          loadingRegister == other.loadingRegister &&
          loadingLogin == other.loadingLogin);

  @override
  int get hashCode =>
      loginForm.hashCode ^
      registerForm.hashCode ^
      user.hashCode ^
      showPassword.hashCode ^
      loadingRegister.hashCode ^
      loadingLogin.hashCode;

  @override
  String toString() {
    return '''AuthStateModel{ 
         loginForm: $loginForm,
         registerForm: $registerForm,
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
      loginForm: loginForm ?? this.loginForm,
      registerForm: registerForm ?? this.registerForm,
      user: setUserOnNull ? user : user ?? this.user,
      showPassword: showPassword ?? this.showPassword,
      loadingRegister: loadingRegister ?? this.loadingRegister,
      loadingLogin: loadingLogin ?? this.loadingLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loginForm': loginForm,
      'registerForm': registerForm,
      'user': user,
      'showPassword': showPassword,
      'loadingRegister': loadingRegister,
      'loadingLogin': loadingLogin,
    };
  }

  factory AuthStateModel.fromMap(Map<String, dynamic> map) {
    return AuthStateModel(
      loginForm: map['loginForm'] as GlobalKey<FormState>,
      registerForm: map['registerForm'] as GlobalKey<FormState>,
      user: map['user'] as User,
      showPassword: map['showPassword'] as bool,
      loadingRegister: map['loadingRegister'] as bool,
      loadingLogin: map['loadingLogin'] as bool,
    );
  }

// void setUser(User? user) => _user = user;
//
// void changePasswordVisibility() => _showPassword = !_showPassword;
//
// void changeRegisterLoading(bool value) => _loadingRegister = value;
//
// void changeLoginLoading(bool value) => _loadingLogin = value;
}
