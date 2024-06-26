import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/core/utils/extensions/extentions.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:yahay/injections/injections.dart';

class OtherAuthorizationImpl implements OtherAuthorization {
  final DioSettings _dioSettings = snoopy<DioSettings>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _sharedPreferences = snoopy<SharedPreferHelper>();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final String _googleAuthPath = "${AppHttpRoutes.authPrefix}/google-auth";
  final String _facebookAuthPath = "${AppHttpRoutes.authPrefix}/facebook-auth";

  @override
  Future<UserModel?> faceBookAuth() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();

      if (loginResult.status == LoginStatus.failed || loginResult.status == LoginStatus.cancelled) {
        return null;
      }

      final userData = await FacebookAuth.instance.getUserData();

      final body = {
        "facebook_id": loginResult.accessToken?.userId,
        "name": userData.getValueByKey("name"),
        "email": userData.getValueByKey("email"),
        "image_url": userData['picture']['data']['url'],
      };

      final response = await _dioSettings.dio.post(_facebookAuthPath, data: body);

      debugPrint("facebook auth laravel response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } catch (e) {
      debugPrint("faceBookAuth error is $e");
      return null;
    }
  }

  @override
  Future<UserModel?> googleAuth() async {
    debugPrint("sending after url: ${_dioSettings.dio.options.baseUrl}$_googleAuthPath");
    try {
      final googleAccount = await _googleSignIn.signIn();

      if (googleAccount == null) return null;

      final body = {
        "email": googleAccount.email,
        "google_id": googleAccount.id,
        "image_url": googleAccount.photoUrl,
      };

      debugPrint("sending body is: $body");

      final response = await _dioSettings.dio.post(_googleAuthPath, data: body);

      debugPrint("google auth laravel response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) {
        return null;
      }

      await _sharedPreferences.setStringByKey(key: "token", value: json['token']);

      return UserModel.fromJson(json['user']);
    } catch (e) {
      debugPrint("google auth error is: $e");
      return null;
    }
  }
}
