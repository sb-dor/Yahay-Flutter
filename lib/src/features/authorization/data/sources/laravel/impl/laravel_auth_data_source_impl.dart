import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
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

      if (response.containsKey(HttpServerResponses.serverSuccessResponse) &&
          response[HttpServerResponses.serverSuccessResponse] == false) {
        return null;
      }

      return UserModel.fromJson(response.getNested(['user']));
    } on RestClientException {
      rethrow;
    }
  }

  @override
  Future<UserModel?> login({
    required final String emailOrUserName,
    required final String password,
  }) async {
    final url = "${AppHttpRoutes.authPrefix}$_login";

    Map<String, dynamic> body = {
      "email_or_username": emailOrUserName,
      "password": password,
    };

    final response = await _restClientBase.post(url, data: body);

    if (response == null) return null;

    _logger.log(Level.debug, "login response: $response | ${response.runtimeType}");

    if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) {
      return null;
    }

    if (response[HttpServerResponses.serverSuccessResponse] == false) {
      _screenMessaging.toast((response['message'] ?? '') as String);
      return null;
    }

    await _sharedPreferences.setStringByKey(key: "token", value: response.getNested(['token']));

    return UserModel.fromJson(response.getNested(['user']));
  }

  @override
  Future<UserModel?> register({
    required final String email,
    required final String password,
    required final String userName,
  }) async {
    final url = "${AppHttpRoutes.authPrefix}$_register";

    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "user_name": userName,
    };

    final response = await _restClientBase.post(url, data: body);

    if (response == null) return null;

    _logger.log(Level.debug, "register response: $response");

    if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) {
      return null;
    }

    if (response[HttpServerResponses.serverSuccessResponse] == false) {
      _screenMessaging.toast(response.getNested(['message']));
      return null;
    }

    await _sharedPreferences.setStringByKey(key: "token", value: response.getNested(['token']));

    return UserModel.fromJson(response.getNested(['user']));
  }

  @override
  Future<bool> logout() async {
    try {
      final url = "${AppHttpRoutes.authPrefix}$_logout";

      final response = await _restClientBase.delete(url);

      if (response == null) return false;

      _logger.log(Level.debug, "logout response: $response");

      if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) return false;

      if (response[HttpServerResponses.serverSuccessResponse] == true) {
        return true;
      }

      return false;
    } on RestClientException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
