import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class OtherAuthorizationImpl implements OtherAuthorization {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  @override
  Future<UserModel?> faceBookAuth() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();

      debugPrint("face book loginresult: ${loginResult.accessToken?.userId}");
    } catch (e) {
      debugPrint("faceBookAuth error is $e");
      return null;
    }
  }

  @override
  Future<UserModel?> googleAuth() async {
    try {
      final data = await _googleSignIn.signIn();

      debugPrint("google auth user: ${data?.email} | ${data?.id}");

      if (data == null) return null;
    } catch (e) {
      debugPrint("google auth error is: $e");
      return null;
    }
  }
}
