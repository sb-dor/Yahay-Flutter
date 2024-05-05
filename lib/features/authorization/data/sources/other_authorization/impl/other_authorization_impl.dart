import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';

class OtherAuthorizationImpl implements OtherAuthorization {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel?> faceBookAuth() async {
    try {} catch (e) {
      debugPrint("");
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
