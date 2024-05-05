import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/core/utils/screen_messaging/screen_messaging.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/injections/injections.dart';

class LaravelAuthDataSourceImpl implements LaravelAuthDataSource {
  final _dio = snoopy<DioSettings>();
  final _sharedPreferences = snoopy<SharedPreferHelper>();
  final _screenMessaging = snoopy<ScreenMessaging>();

  final String _checkAuth = "/check-auth";
  final String _register = "/register";
  final String _login = "/login";

  @override
  Future<UserModel?> checkAuth() async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_checkAuth";

      final response = await _dio.dio.get(url);

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json = jsonDecode(response.data);

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) return null;

      return UserModel.fromJson(json['user']);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> login({
    required final String emailOrUserName,
    required final String password,
  }) async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_login";

      Map<String, dynamic> body = {
        "email_or_username": emailOrUserName,
        "password": password,
      };

      final response = await _dio.dio.post(url, data: body);

      debugPrint("login response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json = jsonDecode(response.data);

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        _screenMessaging.toast(json['message'] ?? '');
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> register({
    required final String email,
    required final String password,
    required final String userName,
  }) async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_register";

      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "user_name": userName,
      };

      final response = await _dio.dio.post(url, data: body);

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json = jsonDecode(response.data);

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        _screenMessaging.toast(json['message'] ?? '');
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } catch (e) {
      return null;
    }
  }
}
