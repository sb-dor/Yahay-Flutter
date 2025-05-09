import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yahay/src/core/utils/dio/src/http_routes/http_routes.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/extensions/extensions.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class OtherAuthorizationImpl implements OtherAuthorizationDatasource {
  //
  OtherAuthorizationImpl({
    required final GoogleSignIn googleSignIn,
    required final FacebookAuth facebookAuth,
    required final SharedPreferHelper sharedPreferHelper,
    required final RestClientBase restClientBase,
  }) : _googleSignIn = googleSignIn,
       _facebookAuth = facebookAuth,
       _sharedPreferHelper = sharedPreferHelper,
       _restClientBase = restClientBase;

  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final SharedPreferHelper _sharedPreferHelper;
  final RestClientBase _restClientBase;

  final String _googleAuthPath = "${HttpRoutes.authPrefix}/google-auth";

  final String _facebookAuthPath = "${HttpRoutes.authPrefix}/facebook-auth";

  @override
  Future<UserModel?> faceBookAuth() async {
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

    final response = await _restClientBase.post(_facebookAuthPath, data: body);

    if (response == null) return null;

    if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) {
      return null;
    }

    await _sharedPreferHelper.setStringByKey(key: "token", value: response.getNested(['token']));

    return UserModel.fromJson(response.getNested(['user']));
  }

  @override
  Future<UserModel?> googleAuth() async {
    // debugPrint("sending after url: ${_dioSettings.dio.options.baseUrl}$_googleAuthPath");
    final googleAccount = await _googleSignIn.signIn();

    if (googleAccount == null) return null;

    final body = {
      "email": googleAccount.email,
      "google_id": googleAccount.id,
      "image_url": googleAccount.photoUrl,
    };

    debugPrint("sending body is: $body");

    final response = await _restClientBase.post(_googleAuthPath, data: body);

    if (response == null) return null;

    if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) {
      return null;
    }

    await _sharedPreferHelper.setStringByKey(key: "token", value: response.getNested(['token']));

    return UserModel.fromJson(response.getNested(['user']));
  }
}
