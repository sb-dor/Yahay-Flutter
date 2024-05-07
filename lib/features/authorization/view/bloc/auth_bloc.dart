import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/features/authorization/domain/repo/other_authorization_repo.dart';
import 'package:yahay/features/authorization/domain/usecases/check_token_usecase.dart';
import 'package:yahay/features/authorization/domain/usecases/facebook_auth_usecase.dart';
import 'package:yahay/features/authorization/domain/usecases/google_auth_usecase.dart';
import 'package:yahay/features/authorization/domain/usecases/login_usecase.dart';
import 'package:yahay/features/authorization/domain/usecases/register_usecase.dart';
import 'package:yahay/features/authorization/view/bloc/state_model/auth_state_model.dart';

import 'auth_events.dart';
import 'auth_states.dart';

@immutable
class AuthBloc {
  static late final AuthStateModel _currentStateModel;
  static late final AuthorizationRepo _authorizationRepo;
  static late final OtherAuthorizationRepo _otherAuthorizationRepo;
  static late final CheckTokenUseCase _checkTokenUseCase;
  static late final RegisterUsecase _registerUsecase;
  static late final LoginUsecase _loginUsecase;
  static late final GoogleAuthUsecase _googleAuthUsecase;
  static late final FacebookAuthUsecase _facebookAuthUsecase;
  static late final BehaviorSubject<AuthStates> _currentState;

  // state data
  final Sink<AuthEvents> events;
  final BehaviorSubject<AuthStates> _states;

  Stream<AuthStates> get states => _states.stream;

  const AuthBloc._({
    required this.events,
    required BehaviorSubject<AuthStates> states,
  }) : _states = states;

  factory AuthBloc({
    required AuthorizationRepo authorizationRepo,
    required OtherAuthorizationRepo otherAuthorizationRepo,
  }) {
    _currentStateModel = AuthStateModel();
    _authorizationRepo = authorizationRepo;
    _otherAuthorizationRepo = otherAuthorizationRepo;
    _checkTokenUseCase = CheckTokenUseCase(_authorizationRepo);
    _registerUsecase = RegisterUsecase(_authorizationRepo);
    _googleAuthUsecase = GoogleAuthUsecase(_otherAuthorizationRepo);
    _facebookAuthUsecase = FacebookAuthUsecase(_otherAuthorizationRepo);
    _loginUsecase = LoginUsecase(_authorizationRepo);

    final eventBehavior = BehaviorSubject<AuthEvents>();

    final stateFlow = eventBehavior.asyncMap<AuthStates>((authEvents) async {
      return await _eventHandler(authEvents);
    }).startWith(LoadingAuthState(_currentStateModel));

    final behaviorStateFlow = BehaviorSubject<AuthStates>()..addStream(stateFlow);

    _currentState = behaviorStateFlow;

    return AuthBloc._(
      events: eventBehavior.sink,
      states: behaviorStateFlow,
    );
  }

  static Future<AuthStates> _eventHandler(AuthEvents event) async {
    AuthStates state = LoadingAuthState(_currentStateModel);
    if (event is CheckAuthEvent) {
      state = await _checkAuthEvent(event);
    } else if (event is RegisterEvent) {
      state = await _registerEvent(event);
    } else if (event is LoginEvent) {
      state = await _loginEvent(event);
    } else if (event is ChangePasswordVisibility) {
      state = _changePasswordVisibility(event);
    } else if (event is GoogleAuth) {
      state = await _googleAuth(event);
    } else if (event is FacebookAuth) {
      state = await _facebookAuth(event);
    }
    return state;
  }

  static Future<AuthStates> _checkAuthEvent(CheckAuthEvent event) async {
    try {
      final user = await _checkTokenUseCase.checkAuth();

      debugPrint("working auth checktoken");

      if (user == null) return UnAuthorizedState(_currentStateModel);

      _currentStateModel.setUser(user);

      return AuthorizedState(_currentStateModel);
    } catch (e) {
      return ErrorAuthState(_currentStateModel);
    }
  }

  static Future<AuthStates> _registerEvent(RegisterEvent event) async {
    try {
      if (!(_currentStateModel.registerForm.currentState?.validate() ?? false)) return _emitter();

      _currentStateModel.changeRegisterLoading(true);

      _emitter();

      final user = await _registerUsecase.register(
        email: event.email.trim(),
        password: event.password.trim(),
        userName: event.userName.trim(),
      );

      debugPrint("even coming here $user");

      _currentStateModel.changeRegisterLoading(false);

      if (user == null) return UnAuthorizedState(_currentStateModel);

      _currentStateModel.setUser(user);

      return AuthorizedState(_currentStateModel);
    } catch (e) {
      return ErrorAuthState(_currentStateModel);
    }
  }

  static Future<AuthStates> _loginEvent(LoginEvent event) async {
    try {
      if (!(_currentStateModel.loginForm.currentState?.validate() ?? false)) return _emitter();

      _currentStateModel.changeLoginLoading(true);

      _emitter();

      final user = await _loginUsecase.login(
        emailOrUserName: event.emailOrUserName.trim(),
        password: event.password.trim(),
      );

      _currentStateModel.changeLoginLoading(false);

      if (user == null) return UnAuthorizedState(_currentStateModel);

      return AuthorizedState(_currentStateModel);
    } catch (e) {
      return ErrorAuthState(_currentStateModel);
    }
  }

  static AuthStates _changePasswordVisibility(ChangePasswordVisibility event) {
    _currentStateModel.changePasswordVisibility();
    return _emitter();
  }

  static Future<AuthStates> _googleAuth(GoogleAuth event) async {
    try {
      final user = await _googleAuthUsecase.googleAuth();

      if (user == null) return UnAuthorizedState(_currentStateModel);

      _currentStateModel.setUser(user);

      return AuthorizedState(_currentStateModel);
    } catch (e) {
      return ErrorAuthState(_currentStateModel);
    }
  }

  static Future<AuthStates> _facebookAuth(FacebookAuth event) async {
    try {
      final user = await _facebookAuthUsecase.facebookAuth();

      if (user == null) return UnAuthorizedState(_currentStateModel);

      _currentStateModel.setUser(user);

      return AuthorizedState(_currentStateModel);
    } catch (e) {
      return ErrorAuthState(_currentStateModel);
    }
  }

  static AuthStates _emitter() {
    if (_currentState.value is LoadingAuthState) {
      return LoadingAuthState(_currentStateModel);
    } else if (_currentState.value is AuthorizedState) {
      return AuthorizedState(_currentStateModel);
    } else if (_currentState.value is UnAuthorizedState) {
      return UnAuthorizedState(_currentStateModel);
    } else if (_currentState.value is ErrorAuthState) {
      return ErrorAuthState(_currentStateModel);
    } else {
      return LoadingAuthState(_currentStateModel);
    }
  }
}
