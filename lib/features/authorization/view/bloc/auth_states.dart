import 'package:flutter/foundation.dart';

import 'state_model/auth_state_model.dart';

@immutable
abstract class AuthStates {
  final AuthStateModel authStateModel;

  const AuthStates(this.authStateModel);
}

@immutable
class LoadingAuthState extends AuthStates {
  const LoadingAuthState(super.authStateModel);
}

@immutable
class AuthorizedState extends AuthStates {
  const AuthorizedState(super.authStateModel);
}

@immutable
class UnAuthorizedState extends AuthStates {
  const UnAuthorizedState(super.authStateModel);
}

@immutable
class ErrorAuthState extends AuthStates {
  const ErrorAuthState(super.authStateModel);
}
