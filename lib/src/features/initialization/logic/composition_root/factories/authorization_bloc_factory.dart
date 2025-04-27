import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';
import 'package:yahay/src/core/utils/screen_messaging/screen_messaging.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/authorization/bloc/state_model/auth_state_model.dart';
import 'package:yahay/src/features/authorization/data/repo/authorization_repo_impl.dart';
import 'package:yahay/src/features/authorization/data/repo/other_authorization_repo_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/impl/laravel_auth_data_source_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/impl/other_authorization_impl.dart';
import 'package:yahay/src/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class AuthorizationBlocFactory extends Factory<AuthBloc> {
  AuthorizationBlocFactory({
    required final GoogleSignIn googleSignIn,
    required final FacebookAuth facebookAuth,
    required final SharedPreferHelper sharedPreferHelper,
    required final Logger logger,
    required final RestClientBase restClientBase,
  }) : _googleSignIn = googleSignIn,
       _facebookAuth = facebookAuth,
       _sharedPreferHelper = sharedPreferHelper,
       _logger = logger,
       _restClientBase = restClientBase;

  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final SharedPreferHelper _sharedPreferHelper;
  final Logger _logger;
  final RestClientBase _restClientBase;

  @override
  AuthBloc create() {
    final LaravelAuthDataSource laravelAuthDataSource = LaravelAuthDataSourceImpl(
      sharedPreferences: _sharedPreferHelper,
      restClientBase: _restClientBase,
      screenMessaging: ScreenMessaging.instance,
      logger: _logger,
    );

    final OtherAuthorizationDatasource otherAuthorizationDatasource = OtherAuthorizationImpl(
      googleSignIn: _googleSignIn,
      facebookAuth: _facebookAuth,
      sharedPreferHelper: _sharedPreferHelper,
      restClientBase: _restClientBase,
    );

    final AuthorizationRepo authorizationRepo = AuthorizationRepoImpl(laravelAuthDataSource);

    final OtherAuthorizationRepo otherAuthorizationRepo = OtherAuthorizationRepoImpl(
      otherAuthorizationDatasource,
    );

    final initialState = AuthStates.initial(AuthStateModel.idle());

    return AuthBloc(
      authorizationRepo: authorizationRepo,
      otherAuthorizationRepo: otherAuthorizationRepo,
      initialState: initialState,
    );
  }
}
