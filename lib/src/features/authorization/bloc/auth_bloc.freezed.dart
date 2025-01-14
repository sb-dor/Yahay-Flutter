// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventsCopyWith<$Res> {
  factory $AuthEventsCopyWith(
          AuthEvents value, $Res Function(AuthEvents) then) =
      _$AuthEventsCopyWithImpl<$Res, AuthEvents>;
}

/// @nodoc
class _$AuthEventsCopyWithImpl<$Res, $Val extends AuthEvents>
    implements $AuthEventsCopyWith<$Res> {
  _$AuthEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GoogleAuthEventOnAuthEventsImplCopyWith<$Res> {
  factory _$$GoogleAuthEventOnAuthEventsImplCopyWith(
          _$GoogleAuthEventOnAuthEventsImpl value,
          $Res Function(_$GoogleAuthEventOnAuthEventsImpl) then) =
      __$$GoogleAuthEventOnAuthEventsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({void Function() initChatsBloc});
}

/// @nodoc
class __$$GoogleAuthEventOnAuthEventsImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$GoogleAuthEventOnAuthEventsImpl>
    implements _$$GoogleAuthEventOnAuthEventsImplCopyWith<$Res> {
  __$$GoogleAuthEventOnAuthEventsImplCopyWithImpl(
      _$GoogleAuthEventOnAuthEventsImpl _value,
      $Res Function(_$GoogleAuthEventOnAuthEventsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initChatsBloc = null,
  }) {
    return _then(_$GoogleAuthEventOnAuthEventsImpl(
      null == initChatsBloc
          ? _value.initChatsBloc
          : initChatsBloc // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$GoogleAuthEventOnAuthEventsImpl
    implements _GoogleAuthEventOnAuthEvents {
  const _$GoogleAuthEventOnAuthEventsImpl(this.initChatsBloc);

  @override
  final void Function() initChatsBloc;

  @override
  String toString() {
    return 'AuthEvents.googleAuth(initChatsBloc: $initChatsBloc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleAuthEventOnAuthEventsImpl &&
            (identical(other.initChatsBloc, initChatsBloc) ||
                other.initChatsBloc == initChatsBloc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initChatsBloc);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleAuthEventOnAuthEventsImplCopyWith<_$GoogleAuthEventOnAuthEventsImpl>
      get copyWith => __$$GoogleAuthEventOnAuthEventsImplCopyWithImpl<
          _$GoogleAuthEventOnAuthEventsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return googleAuth(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return googleAuth?.call(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (googleAuth != null) {
      return googleAuth(initChatsBloc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return googleAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return googleAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (googleAuth != null) {
      return googleAuth(this);
    }
    return orElse();
  }
}

abstract class _GoogleAuthEventOnAuthEvents implements AuthEvents {
  const factory _GoogleAuthEventOnAuthEvents(
      final void Function() initChatsBloc) = _$GoogleAuthEventOnAuthEventsImpl;

  void Function() get initChatsBloc;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoogleAuthEventOnAuthEventsImplCopyWith<_$GoogleAuthEventOnAuthEventsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FacebookAuthEventsAuthEventsImplCopyWith<$Res> {
  factory _$$FacebookAuthEventsAuthEventsImplCopyWith(
          _$FacebookAuthEventsAuthEventsImpl value,
          $Res Function(_$FacebookAuthEventsAuthEventsImpl) then) =
      __$$FacebookAuthEventsAuthEventsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({void Function() initChatsBloc});
}

/// @nodoc
class __$$FacebookAuthEventsAuthEventsImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$FacebookAuthEventsAuthEventsImpl>
    implements _$$FacebookAuthEventsAuthEventsImplCopyWith<$Res> {
  __$$FacebookAuthEventsAuthEventsImplCopyWithImpl(
      _$FacebookAuthEventsAuthEventsImpl _value,
      $Res Function(_$FacebookAuthEventsAuthEventsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initChatsBloc = null,
  }) {
    return _then(_$FacebookAuthEventsAuthEventsImpl(
      null == initChatsBloc
          ? _value.initChatsBloc
          : initChatsBloc // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$FacebookAuthEventsAuthEventsImpl
    implements _FacebookAuthEventsAuthEvents {
  const _$FacebookAuthEventsAuthEventsImpl(this.initChatsBloc);

  @override
  final void Function() initChatsBloc;

  @override
  String toString() {
    return 'AuthEvents.facebookAuth(initChatsBloc: $initChatsBloc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FacebookAuthEventsAuthEventsImpl &&
            (identical(other.initChatsBloc, initChatsBloc) ||
                other.initChatsBloc == initChatsBloc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initChatsBloc);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FacebookAuthEventsAuthEventsImplCopyWith<
          _$FacebookAuthEventsAuthEventsImpl>
      get copyWith => __$$FacebookAuthEventsAuthEventsImplCopyWithImpl<
          _$FacebookAuthEventsAuthEventsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return facebookAuth(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return facebookAuth?.call(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (facebookAuth != null) {
      return facebookAuth(initChatsBloc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return facebookAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return facebookAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (facebookAuth != null) {
      return facebookAuth(this);
    }
    return orElse();
  }
}

abstract class _FacebookAuthEventsAuthEvents implements AuthEvents {
  const factory _FacebookAuthEventsAuthEvents(
      final void Function() initChatsBloc) = _$FacebookAuthEventsAuthEventsImpl;

  void Function() get initChatsBloc;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FacebookAuthEventsAuthEventsImplCopyWith<
          _$FacebookAuthEventsAuthEventsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterEventOnAuthEventsImplCopyWith<$Res> {
  factory _$$RegisterEventOnAuthEventsImplCopyWith(
          _$RegisterEventOnAuthEventsImpl value,
          $Res Function(_$RegisterEventOnAuthEventsImpl) then) =
      __$$RegisterEventOnAuthEventsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String email,
      String password,
      String userName,
      void Function() initChatsBloc});
}

/// @nodoc
class __$$RegisterEventOnAuthEventsImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$RegisterEventOnAuthEventsImpl>
    implements _$$RegisterEventOnAuthEventsImplCopyWith<$Res> {
  __$$RegisterEventOnAuthEventsImplCopyWithImpl(
      _$RegisterEventOnAuthEventsImpl _value,
      $Res Function(_$RegisterEventOnAuthEventsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? initChatsBloc = null,
  }) {
    return _then(_$RegisterEventOnAuthEventsImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      initChatsBloc: null == initChatsBloc
          ? _value.initChatsBloc
          : initChatsBloc // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$RegisterEventOnAuthEventsImpl implements _RegisterEventOnAuthEvents {
  const _$RegisterEventOnAuthEventsImpl(
      {required this.email,
      required this.password,
      required this.userName,
      required this.initChatsBloc});

  @override
  final String email;
  @override
  final String password;
  @override
  final String userName;
  @override
  final void Function() initChatsBloc;

  @override
  String toString() {
    return 'AuthEvents.registerEvent(email: $email, password: $password, userName: $userName, initChatsBloc: $initChatsBloc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterEventOnAuthEventsImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.initChatsBloc, initChatsBloc) ||
                other.initChatsBloc == initChatsBloc));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, userName, initChatsBloc);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterEventOnAuthEventsImplCopyWith<_$RegisterEventOnAuthEventsImpl>
      get copyWith => __$$RegisterEventOnAuthEventsImplCopyWithImpl<
          _$RegisterEventOnAuthEventsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return registerEvent(email, password, userName, initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return registerEvent?.call(email, password, userName, initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (registerEvent != null) {
      return registerEvent(email, password, userName, initChatsBloc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return registerEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return registerEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (registerEvent != null) {
      return registerEvent(this);
    }
    return orElse();
  }
}

abstract class _RegisterEventOnAuthEvents implements AuthEvents {
  const factory _RegisterEventOnAuthEvents(
          {required final String email,
          required final String password,
          required final String userName,
          required final void Function() initChatsBloc}) =
      _$RegisterEventOnAuthEventsImpl;

  String get email;
  String get password;
  String get userName;
  void Function() get initChatsBloc;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterEventOnAuthEventsImplCopyWith<_$RegisterEventOnAuthEventsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginEventOnAuthEventsImplCopyWith<$Res> {
  factory _$$LoginEventOnAuthEventsImplCopyWith(
          _$LoginEventOnAuthEventsImpl value,
          $Res Function(_$LoginEventOnAuthEventsImpl) then) =
      __$$LoginEventOnAuthEventsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String emailOrUserName, String password, void Function() initChatsBloc});
}

/// @nodoc
class __$$LoginEventOnAuthEventsImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$LoginEventOnAuthEventsImpl>
    implements _$$LoginEventOnAuthEventsImplCopyWith<$Res> {
  __$$LoginEventOnAuthEventsImplCopyWithImpl(
      _$LoginEventOnAuthEventsImpl _value,
      $Res Function(_$LoginEventOnAuthEventsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailOrUserName = null,
    Object? password = null,
    Object? initChatsBloc = null,
  }) {
    return _then(_$LoginEventOnAuthEventsImpl(
      emailOrUserName: null == emailOrUserName
          ? _value.emailOrUserName
          : emailOrUserName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      initChatsBloc: null == initChatsBloc
          ? _value.initChatsBloc
          : initChatsBloc // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$LoginEventOnAuthEventsImpl implements _LoginEventOnAuthEvents {
  const _$LoginEventOnAuthEventsImpl(
      {required this.emailOrUserName,
      required this.password,
      required this.initChatsBloc});

  @override
  final String emailOrUserName;
  @override
  final String password;
  @override
  final void Function() initChatsBloc;

  @override
  String toString() {
    return 'AuthEvents.loginEvent(emailOrUserName: $emailOrUserName, password: $password, initChatsBloc: $initChatsBloc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginEventOnAuthEventsImpl &&
            (identical(other.emailOrUserName, emailOrUserName) ||
                other.emailOrUserName == emailOrUserName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.initChatsBloc, initChatsBloc) ||
                other.initChatsBloc == initChatsBloc));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, emailOrUserName, password, initChatsBloc);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginEventOnAuthEventsImplCopyWith<_$LoginEventOnAuthEventsImpl>
      get copyWith => __$$LoginEventOnAuthEventsImplCopyWithImpl<
          _$LoginEventOnAuthEventsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return loginEvent(emailOrUserName, password, initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return loginEvent?.call(emailOrUserName, password, initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (loginEvent != null) {
      return loginEvent(emailOrUserName, password, initChatsBloc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return loginEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return loginEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (loginEvent != null) {
      return loginEvent(this);
    }
    return orElse();
  }
}

abstract class _LoginEventOnAuthEvents implements AuthEvents {
  const factory _LoginEventOnAuthEvents(
          {required final String emailOrUserName,
          required final String password,
          required final void Function() initChatsBloc}) =
      _$LoginEventOnAuthEventsImpl;

  String get emailOrUserName;
  String get password;
  void Function() get initChatsBloc;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginEventOnAuthEventsImplCopyWith<_$LoginEventOnAuthEventsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckAuthEventOnAuthEventsImplCopyWith<$Res> {
  factory _$$CheckAuthEventOnAuthEventsImplCopyWith(
          _$CheckAuthEventOnAuthEventsImpl value,
          $Res Function(_$CheckAuthEventOnAuthEventsImpl) then) =
      __$$CheckAuthEventOnAuthEventsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({void Function() initChatsBloc});
}

/// @nodoc
class __$$CheckAuthEventOnAuthEventsImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$CheckAuthEventOnAuthEventsImpl>
    implements _$$CheckAuthEventOnAuthEventsImplCopyWith<$Res> {
  __$$CheckAuthEventOnAuthEventsImplCopyWithImpl(
      _$CheckAuthEventOnAuthEventsImpl _value,
      $Res Function(_$CheckAuthEventOnAuthEventsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initChatsBloc = null,
  }) {
    return _then(_$CheckAuthEventOnAuthEventsImpl(
      initChatsBloc: null == initChatsBloc
          ? _value.initChatsBloc
          : initChatsBloc // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$CheckAuthEventOnAuthEventsImpl implements _CheckAuthEventOnAuthEvents {
  const _$CheckAuthEventOnAuthEventsImpl({required this.initChatsBloc});

  @override
  final void Function() initChatsBloc;

  @override
  String toString() {
    return 'AuthEvents.checkAuthEvent(initChatsBloc: $initChatsBloc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckAuthEventOnAuthEventsImpl &&
            (identical(other.initChatsBloc, initChatsBloc) ||
                other.initChatsBloc == initChatsBloc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initChatsBloc);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckAuthEventOnAuthEventsImplCopyWith<_$CheckAuthEventOnAuthEventsImpl>
      get copyWith => __$$CheckAuthEventOnAuthEventsImplCopyWithImpl<
          _$CheckAuthEventOnAuthEventsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return checkAuthEvent(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return checkAuthEvent?.call(initChatsBloc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (checkAuthEvent != null) {
      return checkAuthEvent(initChatsBloc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return checkAuthEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return checkAuthEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (checkAuthEvent != null) {
      return checkAuthEvent(this);
    }
    return orElse();
  }
}

abstract class _CheckAuthEventOnAuthEvents implements AuthEvents {
  const factory _CheckAuthEventOnAuthEvents(
          {required final void Function() initChatsBloc}) =
      _$CheckAuthEventOnAuthEventsImpl;

  void Function() get initChatsBloc;

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckAuthEventOnAuthEventsImplCopyWith<_$CheckAuthEventOnAuthEventsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePasswordVisibilityEventImplCopyWith<$Res> {
  factory _$$ChangePasswordVisibilityEventImplCopyWith(
          _$ChangePasswordVisibilityEventImpl value,
          $Res Function(_$ChangePasswordVisibilityEventImpl) then) =
      __$$ChangePasswordVisibilityEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChangePasswordVisibilityEventImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$ChangePasswordVisibilityEventImpl>
    implements _$$ChangePasswordVisibilityEventImplCopyWith<$Res> {
  __$$ChangePasswordVisibilityEventImplCopyWithImpl(
      _$ChangePasswordVisibilityEventImpl _value,
      $Res Function(_$ChangePasswordVisibilityEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChangePasswordVisibilityEventImpl
    implements _ChangePasswordVisibilityEvent {
  const _$ChangePasswordVisibilityEventImpl();

  @override
  String toString() {
    return 'AuthEvents.changePasswordVisibility()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordVisibilityEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return changePasswordVisibility();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return changePasswordVisibility?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (changePasswordVisibility != null) {
      return changePasswordVisibility();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return changePasswordVisibility(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return changePasswordVisibility?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (changePasswordVisibility != null) {
      return changePasswordVisibility(this);
    }
    return orElse();
  }
}

abstract class _ChangePasswordVisibilityEvent implements AuthEvents {
  const factory _ChangePasswordVisibilityEvent() =
      _$ChangePasswordVisibilityEventImpl;
}

/// @nodoc
abstract class _$$LogOutEventImplCopyWith<$Res> {
  factory _$$LogOutEventImplCopyWith(
          _$LogOutEventImpl value, $Res Function(_$LogOutEventImpl) then) =
      __$$LogOutEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogOutEventImplCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$LogOutEventImpl>
    implements _$$LogOutEventImplCopyWith<$Res> {
  __$$LogOutEventImplCopyWithImpl(
      _$LogOutEventImpl _value, $Res Function(_$LogOutEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogOutEventImpl implements _LogOutEvent {
  const _$LogOutEventImpl();

  @override
  String toString() {
    return 'AuthEvents.logOutEvent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogOutEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(void Function() initChatsBloc) googleAuth,
    required TResult Function(void Function() initChatsBloc) facebookAuth,
    required TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)
        registerEvent,
    required TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)
        loginEvent,
    required TResult Function(void Function() initChatsBloc) checkAuthEvent,
    required TResult Function() changePasswordVisibility,
    required TResult Function() logOutEvent,
  }) {
    return logOutEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(void Function() initChatsBloc)? googleAuth,
    TResult? Function(void Function() initChatsBloc)? facebookAuth,
    TResult? Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult? Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult? Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult? Function()? changePasswordVisibility,
    TResult? Function()? logOutEvent,
  }) {
    return logOutEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(void Function() initChatsBloc)? googleAuth,
    TResult Function(void Function() initChatsBloc)? facebookAuth,
    TResult Function(String email, String password, String userName,
            void Function() initChatsBloc)?
        registerEvent,
    TResult Function(String emailOrUserName, String password,
            void Function() initChatsBloc)?
        loginEvent,
    TResult Function(void Function() initChatsBloc)? checkAuthEvent,
    TResult Function()? changePasswordVisibility,
    TResult Function()? logOutEvent,
    required TResult orElse(),
  }) {
    if (logOutEvent != null) {
      return logOutEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleAuthEventOnAuthEvents value) googleAuth,
    required TResult Function(_FacebookAuthEventsAuthEvents value) facebookAuth,
    required TResult Function(_RegisterEventOnAuthEvents value) registerEvent,
    required TResult Function(_LoginEventOnAuthEvents value) loginEvent,
    required TResult Function(_CheckAuthEventOnAuthEvents value) checkAuthEvent,
    required TResult Function(_ChangePasswordVisibilityEvent value)
        changePasswordVisibility,
    required TResult Function(_LogOutEvent value) logOutEvent,
  }) {
    return logOutEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult? Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult? Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult? Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult? Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult? Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult? Function(_LogOutEvent value)? logOutEvent,
  }) {
    return logOutEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleAuthEventOnAuthEvents value)? googleAuth,
    TResult Function(_FacebookAuthEventsAuthEvents value)? facebookAuth,
    TResult Function(_RegisterEventOnAuthEvents value)? registerEvent,
    TResult Function(_LoginEventOnAuthEvents value)? loginEvent,
    TResult Function(_CheckAuthEventOnAuthEvents value)? checkAuthEvent,
    TResult Function(_ChangePasswordVisibilityEvent value)?
        changePasswordVisibility,
    TResult Function(_LogOutEvent value)? logOutEvent,
    required TResult orElse(),
  }) {
    if (logOutEvent != null) {
      return logOutEvent(this);
    }
    return orElse();
  }
}

abstract class _LogOutEvent implements AuthEvents {
  const factory _LogOutEvent() = _$LogOutEventImpl;
}

/// @nodoc
mixin _$AuthStates {
  AuthStateModel get authStateModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStatesCopyWith<AuthStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStatesCopyWith<$Res> {
  factory $AuthStatesCopyWith(
          AuthStates value, $Res Function(AuthStates) then) =
      _$AuthStatesCopyWithImpl<$Res, AuthStates>;
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class _$AuthStatesCopyWithImpl<$Res, $Val extends AuthStates>
    implements $AuthStatesCopyWith<$Res> {
  _$AuthStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_value.copyWith(
      authStateModel: null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialStateOnAuthStatesImplCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$InitialStateOnAuthStatesImplCopyWith(
          _$InitialStateOnAuthStatesImpl value,
          $Res Function(_$InitialStateOnAuthStatesImpl) then) =
      __$$InitialStateOnAuthStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class __$$InitialStateOnAuthStatesImplCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$InitialStateOnAuthStatesImpl>
    implements _$$InitialStateOnAuthStatesImplCopyWith<$Res> {
  __$$InitialStateOnAuthStatesImplCopyWithImpl(
      _$InitialStateOnAuthStatesImpl _value,
      $Res Function(_$InitialStateOnAuthStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_$InitialStateOnAuthStatesImpl(
      null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ));
  }
}

/// @nodoc

class _$InitialStateOnAuthStatesImpl implements InitialStateOnAuthStates {
  const _$InitialStateOnAuthStatesImpl(this.authStateModel);

  @override
  final AuthStateModel authStateModel;

  @override
  String toString() {
    return 'AuthStates.initial(authStateModel: $authStateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialStateOnAuthStatesImpl &&
            (identical(other.authStateModel, authStateModel) ||
                other.authStateModel == authStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authStateModel);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialStateOnAuthStatesImplCopyWith<_$InitialStateOnAuthStatesImpl>
      get copyWith => __$$InitialStateOnAuthStatesImplCopyWithImpl<
          _$InitialStateOnAuthStatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) {
    return initial(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) {
    return initial?.call(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(authStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialStateOnAuthStates implements AuthStates {
  const factory InitialStateOnAuthStates(final AuthStateModel authStateModel) =
      _$InitialStateOnAuthStatesImpl;

  @override
  AuthStateModel get authStateModel;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialStateOnAuthStatesImplCopyWith<_$InitialStateOnAuthStatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingStateOnAuthStatesImplCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$LoadingStateOnAuthStatesImplCopyWith(
          _$LoadingStateOnAuthStatesImpl value,
          $Res Function(_$LoadingStateOnAuthStatesImpl) then) =
      __$$LoadingStateOnAuthStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class __$$LoadingStateOnAuthStatesImplCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$LoadingStateOnAuthStatesImpl>
    implements _$$LoadingStateOnAuthStatesImplCopyWith<$Res> {
  __$$LoadingStateOnAuthStatesImplCopyWithImpl(
      _$LoadingStateOnAuthStatesImpl _value,
      $Res Function(_$LoadingStateOnAuthStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_$LoadingStateOnAuthStatesImpl(
      null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ));
  }
}

/// @nodoc

class _$LoadingStateOnAuthStatesImpl implements LoadingStateOnAuthStates {
  const _$LoadingStateOnAuthStatesImpl(this.authStateModel);

  @override
  final AuthStateModel authStateModel;

  @override
  String toString() {
    return 'AuthStates.loading(authStateModel: $authStateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateOnAuthStatesImpl &&
            (identical(other.authStateModel, authStateModel) ||
                other.authStateModel == authStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authStateModel);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingStateOnAuthStatesImplCopyWith<_$LoadingStateOnAuthStatesImpl>
      get copyWith => __$$LoadingStateOnAuthStatesImplCopyWithImpl<
          _$LoadingStateOnAuthStatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) {
    return loading(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) {
    return loading?.call(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(authStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingStateOnAuthStates implements AuthStates {
  const factory LoadingStateOnAuthStates(final AuthStateModel authStateModel) =
      _$LoadingStateOnAuthStatesImpl;

  @override
  AuthStateModel get authStateModel;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingStateOnAuthStatesImplCopyWith<_$LoadingStateOnAuthStatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthorizedStateOnAuthStatesImplCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$AuthorizedStateOnAuthStatesImplCopyWith(
          _$AuthorizedStateOnAuthStatesImpl value,
          $Res Function(_$AuthorizedStateOnAuthStatesImpl) then) =
      __$$AuthorizedStateOnAuthStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class __$$AuthorizedStateOnAuthStatesImplCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$AuthorizedStateOnAuthStatesImpl>
    implements _$$AuthorizedStateOnAuthStatesImplCopyWith<$Res> {
  __$$AuthorizedStateOnAuthStatesImplCopyWithImpl(
      _$AuthorizedStateOnAuthStatesImpl _value,
      $Res Function(_$AuthorizedStateOnAuthStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_$AuthorizedStateOnAuthStatesImpl(
      null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ));
  }
}

/// @nodoc

class _$AuthorizedStateOnAuthStatesImpl implements AuthorizedStateOnAuthStates {
  const _$AuthorizedStateOnAuthStatesImpl(this.authStateModel);

  @override
  final AuthStateModel authStateModel;

  @override
  String toString() {
    return 'AuthStates.authorized(authStateModel: $authStateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizedStateOnAuthStatesImpl &&
            (identical(other.authStateModel, authStateModel) ||
                other.authStateModel == authStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authStateModel);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorizedStateOnAuthStatesImplCopyWith<_$AuthorizedStateOnAuthStatesImpl>
      get copyWith => __$$AuthorizedStateOnAuthStatesImplCopyWithImpl<
          _$AuthorizedStateOnAuthStatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) {
    return authorized(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) {
    return authorized?.call(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) {
    if (authorized != null) {
      return authorized(authStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) {
    return authorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) {
    return authorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) {
    if (authorized != null) {
      return authorized(this);
    }
    return orElse();
  }
}

abstract class AuthorizedStateOnAuthStates implements AuthStates {
  const factory AuthorizedStateOnAuthStates(
      final AuthStateModel authStateModel) = _$AuthorizedStateOnAuthStatesImpl;

  @override
  AuthStateModel get authStateModel;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorizedStateOnAuthStatesImplCopyWith<_$AuthorizedStateOnAuthStatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnAuthorizedStateOnAuthStatesImplCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$UnAuthorizedStateOnAuthStatesImplCopyWith(
          _$UnAuthorizedStateOnAuthStatesImpl value,
          $Res Function(_$UnAuthorizedStateOnAuthStatesImpl) then) =
      __$$UnAuthorizedStateOnAuthStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class __$$UnAuthorizedStateOnAuthStatesImplCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$UnAuthorizedStateOnAuthStatesImpl>
    implements _$$UnAuthorizedStateOnAuthStatesImplCopyWith<$Res> {
  __$$UnAuthorizedStateOnAuthStatesImplCopyWithImpl(
      _$UnAuthorizedStateOnAuthStatesImpl _value,
      $Res Function(_$UnAuthorizedStateOnAuthStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_$UnAuthorizedStateOnAuthStatesImpl(
      null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ));
  }
}

/// @nodoc

class _$UnAuthorizedStateOnAuthStatesImpl
    implements UnAuthorizedStateOnAuthStates {
  const _$UnAuthorizedStateOnAuthStatesImpl(this.authStateModel);

  @override
  final AuthStateModel authStateModel;

  @override
  String toString() {
    return 'AuthStates.unAuthorized(authStateModel: $authStateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnAuthorizedStateOnAuthStatesImpl &&
            (identical(other.authStateModel, authStateModel) ||
                other.authStateModel == authStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authStateModel);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnAuthorizedStateOnAuthStatesImplCopyWith<
          _$UnAuthorizedStateOnAuthStatesImpl>
      get copyWith => __$$UnAuthorizedStateOnAuthStatesImplCopyWithImpl<
          _$UnAuthorizedStateOnAuthStatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) {
    return unAuthorized(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) {
    return unAuthorized?.call(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized(authStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) {
    return unAuthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) {
    return unAuthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) {
    if (unAuthorized != null) {
      return unAuthorized(this);
    }
    return orElse();
  }
}

abstract class UnAuthorizedStateOnAuthStates implements AuthStates {
  const factory UnAuthorizedStateOnAuthStates(
          final AuthStateModel authStateModel) =
      _$UnAuthorizedStateOnAuthStatesImpl;

  @override
  AuthStateModel get authStateModel;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnAuthorizedStateOnAuthStatesImplCopyWith<
          _$UnAuthorizedStateOnAuthStatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorStateOnAuthStatesImplCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$ErrorStateOnAuthStatesImplCopyWith(
          _$ErrorStateOnAuthStatesImpl value,
          $Res Function(_$ErrorStateOnAuthStatesImpl) then) =
      __$$ErrorStateOnAuthStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStateModel authStateModel});
}

/// @nodoc
class __$$ErrorStateOnAuthStatesImplCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$ErrorStateOnAuthStatesImpl>
    implements _$$ErrorStateOnAuthStatesImplCopyWith<$Res> {
  __$$ErrorStateOnAuthStatesImplCopyWithImpl(
      _$ErrorStateOnAuthStatesImpl _value,
      $Res Function(_$ErrorStateOnAuthStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authStateModel = null,
  }) {
    return _then(_$ErrorStateOnAuthStatesImpl(
      null == authStateModel
          ? _value.authStateModel
          : authStateModel // ignore: cast_nullable_to_non_nullable
              as AuthStateModel,
    ));
  }
}

/// @nodoc

class _$ErrorStateOnAuthStatesImpl implements ErrorStateOnAuthStates {
  const _$ErrorStateOnAuthStatesImpl(this.authStateModel);

  @override
  final AuthStateModel authStateModel;

  @override
  String toString() {
    return 'AuthStates.error(authStateModel: $authStateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorStateOnAuthStatesImpl &&
            (identical(other.authStateModel, authStateModel) ||
                other.authStateModel == authStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authStateModel);

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorStateOnAuthStatesImplCopyWith<_$ErrorStateOnAuthStatesImpl>
      get copyWith => __$$ErrorStateOnAuthStatesImplCopyWithImpl<
          _$ErrorStateOnAuthStatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStateModel authStateModel) initial,
    required TResult Function(AuthStateModel authStateModel) loading,
    required TResult Function(AuthStateModel authStateModel) authorized,
    required TResult Function(AuthStateModel authStateModel) unAuthorized,
    required TResult Function(AuthStateModel authStateModel) error,
  }) {
    return error(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStateModel authStateModel)? initial,
    TResult? Function(AuthStateModel authStateModel)? loading,
    TResult? Function(AuthStateModel authStateModel)? authorized,
    TResult? Function(AuthStateModel authStateModel)? unAuthorized,
    TResult? Function(AuthStateModel authStateModel)? error,
  }) {
    return error?.call(authStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStateModel authStateModel)? initial,
    TResult Function(AuthStateModel authStateModel)? loading,
    TResult Function(AuthStateModel authStateModel)? authorized,
    TResult Function(AuthStateModel authStateModel)? unAuthorized,
    TResult Function(AuthStateModel authStateModel)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(authStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialStateOnAuthStates value) initial,
    required TResult Function(LoadingStateOnAuthStates value) loading,
    required TResult Function(AuthorizedStateOnAuthStates value) authorized,
    required TResult Function(UnAuthorizedStateOnAuthStates value) unAuthorized,
    required TResult Function(ErrorStateOnAuthStates value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialStateOnAuthStates value)? initial,
    TResult? Function(LoadingStateOnAuthStates value)? loading,
    TResult? Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult? Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult? Function(ErrorStateOnAuthStates value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialStateOnAuthStates value)? initial,
    TResult Function(LoadingStateOnAuthStates value)? loading,
    TResult Function(AuthorizedStateOnAuthStates value)? authorized,
    TResult Function(UnAuthorizedStateOnAuthStates value)? unAuthorized,
    TResult Function(ErrorStateOnAuthStates value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorStateOnAuthStates implements AuthStates {
  const factory ErrorStateOnAuthStates(final AuthStateModel authStateModel) =
      _$ErrorStateOnAuthStatesImpl;

  @override
  AuthStateModel get authStateModel;

  /// Create a copy of AuthStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorStateOnAuthStatesImplCopyWith<_$ErrorStateOnAuthStatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
