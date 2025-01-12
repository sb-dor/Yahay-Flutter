import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/authorization/data/repo/authorization_repo_impl.dart';
import 'package:yahay/src/features/authorization/data/repo/other_authorization_repo_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/impl/laravel_auth_data_source_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/impl/other_authorization_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';
import 'package:yahay/src/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class AuthorizationBlocFactory extends Factory<AuthBloc> {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final SharedPreferHelper _sharedPreferHelper;

  AuthorizationBlocFactory({
    required final GoogleSignIn googleSignIn,
    required final FacebookAuth facebookAuth,
    required final SharedPreferHelper sharedPreferHelper,
  })  : _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth,
        _sharedPreferHelper = sharedPreferHelper;

  @override
  AuthBloc create() {
    final LaravelAuthDataSource laravelAuthDataSource =
        LaravelAuthDataSourceImpl(_sharedPreferHelper);

    final OtherAuthorizationDatasource otherAuthorizationDatasource = OtherAuthorizationImpl(
      googleSignIn: _googleSignIn,
      facebookAuth: _facebookAuth,
      sharedPreferHelper: _sharedPreferHelper,
    );

    final AuthorizationRepo authorizationRepo = AuthorizationRepoImpl(laravelAuthDataSource);

    final OtherAuthorizationRepo otherAuthorizationRepo = OtherAuthorizationRepoImpl(
      otherAuthorizationDatasource,
    );

    return AuthBloc(
      authorizationRepo: authorizationRepo,
      otherAuthorizationRepo: otherAuthorizationRepo,
      sharedPreferHelper: _sharedPreferHelper,
    );
  }
}
