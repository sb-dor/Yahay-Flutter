import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/user.dart';

class AuthStateModel {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerForm = GlobalKey<FormState>();

  GlobalKey<FormState> get loginForm => _loginForm;

  GlobalKey<FormState> get registerForm => _registerForm;

  User? _user;

  User? get user => _user;

  bool _showPassword = true, _loadingRegister = false, _loadingLogin = false;

  bool get showPassword => _showPassword;

  bool get loadingRegister => _loadingRegister;

  bool get loadingLogin => _loadingLogin;

  void setUser(User? user) => _user = user;

  void changePasswordVisibility() => _showPassword = !_showPassword;

  void changeRegisterLoading(bool value) => _loadingRegister = value;

  void changeLoginLoading(bool value) => _loadingLogin = value;
}
