import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/src/features/authorization/domain/repo/other_authorization_repo.dart';
import 'state_model/auth_state_model.dart';

part 'auth_bloc.freezed.dart';

@immutable
@freezed
class AuthEvents with _$AuthEvents {
  const factory AuthEvents.googleAuth(final void Function() initChatsBloc) =
      _GoogleAuthEventOnAuthEvents;

  const factory AuthEvents.facebookAuth(final void Function() initChatsBloc) =
      _FacebookAuthEventsAuthEvents;

  const factory AuthEvents.registerEvent({
    required final String email,
    required final String password,
    required final String userName,
    required final void Function() initChatsBloc,
  }) = _RegisterEventOnAuthEvents;

  const factory AuthEvents.loginEvent({
    required final String emailOrUserName,
    required final String password,
    required final void Function() initChatsBloc,
  }) = _LoginEventOnAuthEvents;

  const factory AuthEvents.checkAuthEvent({
    required final void Function() initChatsBloc,
  }) = _CheckAuthEventOnAuthEvents;

  const factory AuthEvents.changePasswordVisibility() = _ChangePasswordVisibilityEvent;

  const factory AuthEvents.logOutEvent() = _LogOutEvent;
}

@immutable
@freezed
sealed class AuthStates with _$AuthStates {
  const factory AuthStates.initial(final AuthStateModel authStateModel) = InitialStateOnAuthStates;

  const factory AuthStates.loading(final AuthStateModel authStateModel) = LoadingStateOnAuthStates;

  const factory AuthStates.authorized(final AuthStateModel authStateModel) =
      AuthorizedStateOnAuthStates;

  const factory AuthStates.unAuthorized(final AuthStateModel authStateModel) =
      UnAuthorizedStateOnAuthStates;

  const factory AuthStates.error(final AuthStateModel authStateModel) = ErrorStateOnAuthStates;
}

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthorizationRepo _iAuthorizationRepo;
  final OtherAuthorizationRepo _iOtherAuthorizationRepo;
  final SharedPreferHelper _sharedPreferHelper;

  AuthBloc({
    required AuthorizationRepo authorizationRepo,
    required OtherAuthorizationRepo otherAuthorizationRepo,
    required SharedPreferHelper sharedPreferHelper,
    required AuthStates initialState,
  })  : _iAuthorizationRepo = authorizationRepo,
        _iOtherAuthorizationRepo = otherAuthorizationRepo,
        _sharedPreferHelper = sharedPreferHelper,
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
        changePasswordVisibility: (event) => _changePasswordVisibility(event, emit),
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

      currentStateModel = currentStateModel.copyWith(
        user: user,
      );

      await DioSettings.instance.updateDio(
        _sharedPreferHelper,
      );

      event.initChatsBloc();

      emit(AuthStates.authorized(currentStateModel));
    } catch (error, trace) {
      emit(AuthStates.error(currentStateModel));
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

      currentStateModel = currentStateModel.copyWith(
        user: user,
      );

      await DioSettings.instance.updateDio(
        _sharedPreferHelper,
      );

      event.initChatsBloc();

      emit(AuthStates.authorized(currentStateModel));
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
      if (!(currentStateModel.registerForm.currentState?.validate() ?? false)) {
        _emitter(currentStateModel, emit);
        return;
      }

      currentStateModel = currentStateModel.copyWith(
        loadingRegister: true,
      );

      _emitter(currentStateModel, emit);

      final user = await _iAuthorizationRepo.register(
        email: event.email.trim(),
        password: event.password.trim(),
        userName: event.userName.trim(),
      );

      currentStateModel = currentStateModel.copyWith(
        loadingRegister: false,
      );

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(
        user: user,
      );

      event.initChatsBloc();

      await DioSettings.instance.updateDio(
        _sharedPreferHelper,
      );

      emit(AuthStates.authorized(currentStateModel));
    } catch (e) {
      emit(AuthStates.error(currentStateModel));
    }
  }

  void _loginEvent(
    _LoginEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();

    try {
      if (!(currentStateModel.loginForm.currentState?.validate() ?? false)) {
        _emitter(currentStateModel, emit);
        return;
      }

      currentStateModel = currentStateModel.copyWith(loadingLogin: true);

      _emitter(currentStateModel, emit);

      final user = await _iAuthorizationRepo.login(
        emailOrUserName: event.emailOrUserName.trim(),
        password: event.password.trim(),
      );

      currentStateModel = currentStateModel.copyWith(
        loadingLogin: false,
      );

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(
        user: user,
      );

      await DioSettings.instance.updateDio(
        _sharedPreferHelper,
      );

      event.initChatsBloc();

      emit(AuthStates.authorized(currentStateModel));
    } catch (e) {
      emit(AuthStates.error(currentStateModel));
    }
  }

  void _checkAuthEvent(
    _CheckAuthEventOnAuthEvents event,
    Emitter<AuthStates> emit,
  ) async {
    var currentStateModel = state.authStateModel.copyWith();
    try {
      final user = await _iAuthorizationRepo.checkAuth();

      if (user == null) {
        emit(AuthStates.unAuthorized(currentStateModel));
        return;
      }

      currentStateModel = currentStateModel.copyWith(
        user: user,
      );

      event.initChatsBloc();
      // if yield has "*" it means that you will yield whole stream with value for returning stream
      // if yield has not "*" it meant that you will yield only value for returning stream
      emit(AuthStates.authorized(currentStateModel));
    } catch (e) {
      emit(AuthStates.error(currentStateModel));
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

  void _logOutEvent(
    _LogOutEvent event,
    Emitter<AuthStates> emit,
  ) async {
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
    } catch (e) {
      emit(AuthStates.error(currentStateModel));
    }
  }

  void _emitter(
    AuthStateModel authStateModel,
    Emitter<AuthStates> emit,
  ) {
    switch (state) {
      case InitialStateOnAuthStates():
        emit(AuthStates.initial(authStateModel));
        break;
      case LoadingStateOnAuthStates():
        emit(AuthStates.loading(authStateModel));
        break;
      case AuthorizedStateOnAuthStates():
        emit(AuthStates.authorized(authStateModel));
        break;
      case UnAuthorizedStateOnAuthStates():
        emit(AuthStates.unAuthorized(authStateModel));
        break;
      case ErrorStateOnAuthStates():
        emit(AuthStates.error(authStateModel));
        break;
    }
  }
}
