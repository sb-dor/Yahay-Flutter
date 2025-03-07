import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';
import 'state_model/auth_state_model.dart';

part 'auth_bloc.freezed.dart';

@immutable
@freezed
sealed class AuthEvents with _$AuthEvents {
  const factory AuthEvents.googleAuth({
    required final void Function() initDependenciesAfterAuthorization,
    // required final Future<void> Function() initDioOptions,
  }) = _GoogleAuthEventOnAuthEvents;

  const factory AuthEvents.facebookAuth({
    required final void Function() initDependenciesAfterAuthorization,
    // required final Future<void> Function() initDioOptions,
  }) = _FacebookAuthEventsAuthEvents;

  const factory AuthEvents.registerEvent({
    required final String email,
    required final String password,
    required final String userName,
    required final void Function() initDependenciesAfterAuthorization,
    // required final Future<void> Function() initDioOptions,
  }) = _RegisterEventOnAuthEvents;

  const factory AuthEvents.loginEvent({
    required final String emailOrUserName,
    required final String password,
    required final void Function() initDependenciesAfterAuthorization,
    // required final Future<void> Function() initDioOptions,
  }) = _LoginEventOnAuthEvents;

  const factory AuthEvents.checkAuthEvent({
    required final void Function() initDependenciesAfterAuthorization,
    required void Function(String message) onMessage,
  }) = _CheckAuthEventOnAuthEvents;

  const factory AuthEvents.changePasswordVisibility() =
      _ChangePasswordVisibilityEvent;

  const factory AuthEvents.logOutEvent() = _LogOutEvent;
}

@immutable
@freezed
sealed class AuthStates with _$AuthStates {
  const factory AuthStates.initial(final AuthStateModel authStateModel) =
      Auth$InitialState;

  const factory AuthStates.inProgress(final AuthStateModel authStateModel) =
      AuthStates$InProgressState;

  const factory AuthStates.authorized(final AuthStateModel authStateModel) =
      Auth$AuthorizedState;

  const factory AuthStates.unAuthorized(final AuthStateModel authStateModel) =
      Auth$UnAuthorizedState;

  const factory AuthStates.error(final AuthStateModel authStateModel) =
      ErrorStateOnAuthStates;
}

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthorizationRepo _iAuthorizationRepo;
  final OtherAuthorizationRepo _iOtherAuthorizationRepo;

  AuthBloc({
    required AuthorizationRepo authorizationRepo,
    required OtherAuthorizationRepo otherAuthorizationRepo,
    required AuthStates initialState,
  }) : _iAuthorizationRepo = authorizationRepo,
       _iOtherAuthorizationRepo = otherAuthorizationRepo,
       super(initialState) {
    //
    //
    on<AuthEvents>(
      (event, emit) => event.map(
        googleAuth: (event) => _googleAuth(event, emit),
        facebookAuth: (event) => _facebookAuth(event, emit),
        registerEvent: (event) => _registerEvent(event, emit),
        loginEvent: (event) => _loginEvent(event, emit),
        checkAuthEvent: (event) => _checkAuthEvent(event, emit),
        changePasswordVisibility:
            (event) => _changePasswordVisibility(event, emit),
        logOutEvent: (event) => _logOutEvent(event, emit),
      ),
    );
  }

  void _googleAuth(
    _GoogleAuthEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();

    try {
      final user = await _iOtherAuthorizationRepo.googleAuth();

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(user: user);

      // await event.initDioOptions();

      emit(AuthStates.authorized(currentStateModel));

      event.initDependenciesAfterAuthorization();
    } catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _facebookAuth(
    _FacebookAuthEventsAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();
    try {
      final user = await _iOtherAuthorizationRepo.faceBookAuth();

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(user: user);

      // await event.initDioOptions();

      emit(AuthStates.authorized(currentStateModel));

      event.initDependenciesAfterAuthorization();
    } catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _registerEvent(
    _RegisterEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();
    try {
      currentStateModel = currentStateModel.copyWith(loadingRegister: true);

      _emitter(currentStateModel, emit);

      final user = await _iAuthorizationRepo.register(
        email: event.email.trim(),
        password: event.password.trim(),
        userName: event.userName.trim(),
      );

      currentStateModel = currentStateModel.copyWith(loadingRegister: false);

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(user: user);

      // await event.initDioOptions();
      emit(AuthStates.authorized(currentStateModel));

      event.initDependenciesAfterAuthorization();
    } catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _loginEvent(
    _LoginEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();

    try {
      currentStateModel = currentStateModel.copyWith(loadingLogin: true);

      _emitter(currentStateModel, emit);

      final user = await _iAuthorizationRepo.login(
        emailOrUserName: event.emailOrUserName.trim(),
        password: event.password.trim(),
      );

      currentStateModel = currentStateModel.copyWith(loadingLogin: false);

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(user: user);

      // await event.initDioOptions();

      emit(AuthStates.authorized(currentStateModel));

      event.initDependenciesAfterAuthorization();
    } catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _checkAuthEvent(
    _CheckAuthEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();
    try {
      final user = await _iAuthorizationRepo.checkAuth();

      debugPrint("coming till user: $user");

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(user: user);

      emit(AuthStates.authorized(currentStateModel));

      event.initDependenciesAfterAuthorization();
    } on RestClientException catch (error, stackTrace) {
      if (error is UnauthenticatedException) {
        event.onMessage(error.message);
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      Error.throwWithStackTrace(error, stackTrace);
    } on Object catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _changePasswordVisibility(
    _ChangePasswordVisibilityEvent event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();
    currentStateModel = currentStateModel.copyWith(
      showPassword: !currentStateModel.showPassword,
    );
    _emitter(currentStateModel, emit);
  }

  void _logOutEvent(_LogOutEvent event, Emitter<AuthStates> emit) async {
    var currentStateModel = state.authStateModel.copyWith();
    try {
      final loggedOut = await _iAuthorizationRepo.logout();

      if (loggedOut) {
        currentStateModel = currentStateModel.copyWith(
          user: null,
          setUserOnNull: true,
        );
        emit(AuthStates.unAuthorized(currentStateModel));
      }
    } catch (error, stackTrace) {
      emit(AuthStates.error(currentStateModel));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _emitter(AuthStateModel authStateModel, Emitter<AuthStates> emit) {
    switch (state) {
      case Auth$InitialState():
        emit(AuthStates.initial(authStateModel));
        break;
      case AuthStates$InProgressState():
        emit(AuthStates.inProgress(authStateModel));
        break;
      case Auth$AuthorizedState():
        emit(AuthStates.authorized(authStateModel));
        break;
      case Auth$UnAuthorizedState():
        emit(AuthStates.unAuthorized(authStateModel));
        break;
      case ErrorStateOnAuthStates():
        emit(AuthStates.error(authStateModel));
        break;
    }
  }
}
