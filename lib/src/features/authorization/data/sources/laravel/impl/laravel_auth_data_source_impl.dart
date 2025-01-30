import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/extensions/extentions.dart';
import 'package:yahay/src/core/utils/screen_messaging/screen_messaging.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';

class LaravelAuthDataSourceImpl implements LaravelAuthDataSource {
  LaravelAuthDataSourceImpl({
    required final SharedPreferHelper sharedPreferences,
    required final Logger logger,
    required final RestClientBase restClientBase,
    required final ScreenMessaging screenMessaging,
  })  : _sharedPreferences = sharedPreferences,
        _logger = logger,
        _restClientBase = restClientBase,
        _screenMessaging = screenMessaging;

  final SharedPreferHelper _sharedPreferences;
  final Logger _logger;
  final RestClientBase _restClientBase;
  final ScreenMessaging _screenMessaging;

  final String _checkAuth = "/check-auth";
  final String _register = "/register";
  final String _login = "/login";
  final String _logout = "/logout";

  @override
  Future<UserModel?> checkAuth() async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_checkAuth";

      final response = await _restClientBase.get(url);

      if (response == null) return null;

      _logger.log(Level.debug, "check auth response: $response");

      if (!response.containsKey(HttpStatusCodes.serverSuccessResponse) &&
          response[HttpStatusCodes.serverSuccessResponse] == false) {
        return null;
      }

      return UserModel.fromJson(response.getNested(['user']));
    } catch (e) {
      _logger.log(Level.debug, "error is: $e");
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

      final response = await _dioSettings.dio.post(url, data: body);

      _logger.log(Level.debug, "login response: ${response.data} | ${response.data.runtimeType}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        return null;
      }

      if (json[HttpStatusCodes.serverSuccessResponse] == false) {
        _screenMessaging.toast(json['message'] ?? '');
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        _logger.log(Level.debug, e.response?.data);
        _logger.log(Level.debug, e.response?.headers);
        _logger.log(Level.debug, e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        _logger.log(Level.debug, e.requestOptions);
        _logger.log(Level.debug, e.message);
      }
    } catch (e) {
      _logger.log(Level.debug, "login error is $e");
      return null;
    }
    return null;
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

      final response = await _dioSettings.dio.post(url, data: body);

      _logger.log(Level.debug, "register response: ${response.realUri.path} | ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        return null;
      }

      if (json[HttpStatusCodes.serverSuccessResponse] == false) {
        _screenMessaging.toast(json['message'] ?? '');
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } catch (e) {
      _logger.log(Level.debug, "register error is $e");
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_logout";

      final response = await _dioSettings.dio.delete(url);

      _logger.log(Level.debug, "logout response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return false;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) return false;

      if (json[HttpStatusCodes.serverSuccessResponse] == true) {
        return true;
      }

      return false;
    } catch (e) {
      _logger.log(Level.debug, "logout error is: $e");
      return false;
    }
  }
}
