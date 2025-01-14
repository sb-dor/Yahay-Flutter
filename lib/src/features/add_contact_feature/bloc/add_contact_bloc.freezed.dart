// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddContactsEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchContact,
    required TResult Function(User? user) addContactEvent,
    required TResult Function() clearDataEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchContact,
    TResult? Function(User? user)? addContactEvent,
    TResult? Function()? clearDataEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchContact,
    TResult Function(User? user)? addContactEvent,
    TResult Function()? clearDataEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchContactEvent value) searchContact,
    required TResult Function(_AddContactEventOnAddContactsEvent value)
        addContactEvent,
    required TResult Function(_ClearDataEvent value) clearDataEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchContactEvent value)? searchContact,
    TResult? Function(_AddContactEventOnAddContactsEvent value)?
        addContactEvent,
    TResult? Function(_ClearDataEvent value)? clearDataEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchContactEvent value)? searchContact,
    TResult Function(_AddContactEventOnAddContactsEvent value)? addContactEvent,
    TResult Function(_ClearDataEvent value)? clearDataEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddContactsEventsCopyWith<$Res> {
  factory $AddContactsEventsCopyWith(
          AddContactsEvents value, $Res Function(AddContactsEvents) then) =
      _$AddContactsEventsCopyWithImpl<$Res, AddContactsEvents>;
}

/// @nodoc
class _$AddContactsEventsCopyWithImpl<$Res, $Val extends AddContactsEvents>
    implements $AddContactsEventsCopyWith<$Res> {
  _$AddContactsEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchContactEventImplCopyWith<$Res> {
  factory _$$SearchContactEventImplCopyWith(_$SearchContactEventImpl value,
          $Res Function(_$SearchContactEventImpl) then) =
      __$$SearchContactEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SearchContactEventImplCopyWithImpl<$Res>
    extends _$AddContactsEventsCopyWithImpl<$Res, _$SearchContactEventImpl>
    implements _$$SearchContactEventImplCopyWith<$Res> {
  __$$SearchContactEventImplCopyWithImpl(_$SearchContactEventImpl _value,
      $Res Function(_$SearchContactEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SearchContactEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchContactEventImpl
    with DiagnosticableTreeMixin
    implements _SearchContactEvent {
  const _$SearchContactEventImpl(this.value);

  @override
  final String value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsEvents.searchContact(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddContactsEvents.searchContact'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchContactEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchContactEventImplCopyWith<_$SearchContactEventImpl> get copyWith =>
      __$$SearchContactEventImplCopyWithImpl<_$SearchContactEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchContact,
    required TResult Function(User? user) addContactEvent,
    required TResult Function() clearDataEvent,
  }) {
    return searchContact(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchContact,
    TResult? Function(User? user)? addContactEvent,
    TResult? Function()? clearDataEvent,
  }) {
    return searchContact?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchContact,
    TResult Function(User? user)? addContactEvent,
    TResult Function()? clearDataEvent,
    required TResult orElse(),
  }) {
    if (searchContact != null) {
      return searchContact(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchContactEvent value) searchContact,
    required TResult Function(_AddContactEventOnAddContactsEvent value)
        addContactEvent,
    required TResult Function(_ClearDataEvent value) clearDataEvent,
  }) {
    return searchContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchContactEvent value)? searchContact,
    TResult? Function(_AddContactEventOnAddContactsEvent value)?
        addContactEvent,
    TResult? Function(_ClearDataEvent value)? clearDataEvent,
  }) {
    return searchContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchContactEvent value)? searchContact,
    TResult Function(_AddContactEventOnAddContactsEvent value)? addContactEvent,
    TResult Function(_ClearDataEvent value)? clearDataEvent,
    required TResult orElse(),
  }) {
    if (searchContact != null) {
      return searchContact(this);
    }
    return orElse();
  }
}

abstract class _SearchContactEvent implements AddContactsEvents {
  const factory _SearchContactEvent(final String value) =
      _$SearchContactEventImpl;

  String get value;

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchContactEventImplCopyWith<_$SearchContactEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddContactEventOnAddContactsEventImplCopyWith<$Res> {
  factory _$$AddContactEventOnAddContactsEventImplCopyWith(
          _$AddContactEventOnAddContactsEventImpl value,
          $Res Function(_$AddContactEventOnAddContactsEventImpl) then) =
      __$$AddContactEventOnAddContactsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User? user});
}

/// @nodoc
class __$$AddContactEventOnAddContactsEventImplCopyWithImpl<$Res>
    extends _$AddContactsEventsCopyWithImpl<$Res,
        _$AddContactEventOnAddContactsEventImpl>
    implements _$$AddContactEventOnAddContactsEventImplCopyWith<$Res> {
  __$$AddContactEventOnAddContactsEventImplCopyWithImpl(
      _$AddContactEventOnAddContactsEventImpl _value,
      $Res Function(_$AddContactEventOnAddContactsEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$AddContactEventOnAddContactsEventImpl(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$AddContactEventOnAddContactsEventImpl
    with DiagnosticableTreeMixin
    implements _AddContactEventOnAddContactsEvent {
  const _$AddContactEventOnAddContactsEventImpl(this.user);

  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsEvents.addContactEvent(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddContactsEvents.addContactEvent'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddContactEventOnAddContactsEventImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddContactEventOnAddContactsEventImplCopyWith<
          _$AddContactEventOnAddContactsEventImpl>
      get copyWith => __$$AddContactEventOnAddContactsEventImplCopyWithImpl<
          _$AddContactEventOnAddContactsEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchContact,
    required TResult Function(User? user) addContactEvent,
    required TResult Function() clearDataEvent,
  }) {
    return addContactEvent(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchContact,
    TResult? Function(User? user)? addContactEvent,
    TResult? Function()? clearDataEvent,
  }) {
    return addContactEvent?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchContact,
    TResult Function(User? user)? addContactEvent,
    TResult Function()? clearDataEvent,
    required TResult orElse(),
  }) {
    if (addContactEvent != null) {
      return addContactEvent(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchContactEvent value) searchContact,
    required TResult Function(_AddContactEventOnAddContactsEvent value)
        addContactEvent,
    required TResult Function(_ClearDataEvent value) clearDataEvent,
  }) {
    return addContactEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchContactEvent value)? searchContact,
    TResult? Function(_AddContactEventOnAddContactsEvent value)?
        addContactEvent,
    TResult? Function(_ClearDataEvent value)? clearDataEvent,
  }) {
    return addContactEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchContactEvent value)? searchContact,
    TResult Function(_AddContactEventOnAddContactsEvent value)? addContactEvent,
    TResult Function(_ClearDataEvent value)? clearDataEvent,
    required TResult orElse(),
  }) {
    if (addContactEvent != null) {
      return addContactEvent(this);
    }
    return orElse();
  }
}

abstract class _AddContactEventOnAddContactsEvent implements AddContactsEvents {
  const factory _AddContactEventOnAddContactsEvent(final User? user) =
      _$AddContactEventOnAddContactsEventImpl;

  User? get user;

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddContactEventOnAddContactsEventImplCopyWith<
          _$AddContactEventOnAddContactsEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearDataEventImplCopyWith<$Res> {
  factory _$$ClearDataEventImplCopyWith(_$ClearDataEventImpl value,
          $Res Function(_$ClearDataEventImpl) then) =
      __$$ClearDataEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearDataEventImplCopyWithImpl<$Res>
    extends _$AddContactsEventsCopyWithImpl<$Res, _$ClearDataEventImpl>
    implements _$$ClearDataEventImplCopyWith<$Res> {
  __$$ClearDataEventImplCopyWithImpl(
      _$ClearDataEventImpl _value, $Res Function(_$ClearDataEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearDataEventImpl
    with DiagnosticableTreeMixin
    implements _ClearDataEvent {
  const _$ClearDataEventImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsEvents.clearDataEvent()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'AddContactsEvents.clearDataEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearDataEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchContact,
    required TResult Function(User? user) addContactEvent,
    required TResult Function() clearDataEvent,
  }) {
    return clearDataEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchContact,
    TResult? Function(User? user)? addContactEvent,
    TResult? Function()? clearDataEvent,
  }) {
    return clearDataEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchContact,
    TResult Function(User? user)? addContactEvent,
    TResult Function()? clearDataEvent,
    required TResult orElse(),
  }) {
    if (clearDataEvent != null) {
      return clearDataEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchContactEvent value) searchContact,
    required TResult Function(_AddContactEventOnAddContactsEvent value)
        addContactEvent,
    required TResult Function(_ClearDataEvent value) clearDataEvent,
  }) {
    return clearDataEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchContactEvent value)? searchContact,
    TResult? Function(_AddContactEventOnAddContactsEvent value)?
        addContactEvent,
    TResult? Function(_ClearDataEvent value)? clearDataEvent,
  }) {
    return clearDataEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchContactEvent value)? searchContact,
    TResult Function(_AddContactEventOnAddContactsEvent value)? addContactEvent,
    TResult Function(_ClearDataEvent value)? clearDataEvent,
    required TResult orElse(),
  }) {
    if (clearDataEvent != null) {
      return clearDataEvent(this);
    }
    return orElse();
  }
}

abstract class _ClearDataEvent implements AddContactsEvents {
  const factory _ClearDataEvent() = _$ClearDataEventImpl;
}

/// @nodoc
mixin _$AddContactsStates {
  AddContactStateModel get addContactStateModel =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddContactStateModel addContactStateModel)
        initial,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadingAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        errorAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadedAddContactsState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddContactStateModel addContactStateModel)? initial,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddContactStateModel addContactStateModel)? initial,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAddConstactsState value) initial,
    required TResult Function(LoadingAddContactsState value)
        loadingAddContactsState,
    required TResult Function(ErrorAddContactsState value)
        errorAddContactsState,
    required TResult Function(LoadedAddContactsState value)
        loadedAddContactsState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAddConstactsState value)? initial,
    TResult? Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult? Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult? Function(LoadedAddContactsState value)? loadedAddContactsState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAddConstactsState value)? initial,
    TResult Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult Function(LoadedAddContactsState value)? loadedAddContactsState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddContactsStatesCopyWith<AddContactsStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddContactsStatesCopyWith<$Res> {
  factory $AddContactsStatesCopyWith(
          AddContactsStates value, $Res Function(AddContactsStates) then) =
      _$AddContactsStatesCopyWithImpl<$Res, AddContactsStates>;
  @useResult
  $Res call({AddContactStateModel addContactStateModel});
}

/// @nodoc
class _$AddContactsStatesCopyWithImpl<$Res, $Val extends AddContactsStates>
    implements $AddContactsStatesCopyWith<$Res> {
  _$AddContactsStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addContactStateModel = null,
  }) {
    return _then(_value.copyWith(
      addContactStateModel: null == addContactStateModel
          ? _value.addContactStateModel
          : addContactStateModel // ignore: cast_nullable_to_non_nullable
              as AddContactStateModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialAddConstactsStateImplCopyWith<$Res>
    implements $AddContactsStatesCopyWith<$Res> {
  factory _$$InitialAddConstactsStateImplCopyWith(
          _$InitialAddConstactsStateImpl value,
          $Res Function(_$InitialAddConstactsStateImpl) then) =
      __$$InitialAddConstactsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddContactStateModel addContactStateModel});
}

/// @nodoc
class __$$InitialAddConstactsStateImplCopyWithImpl<$Res>
    extends _$AddContactsStatesCopyWithImpl<$Res,
        _$InitialAddConstactsStateImpl>
    implements _$$InitialAddConstactsStateImplCopyWith<$Res> {
  __$$InitialAddConstactsStateImplCopyWithImpl(
      _$InitialAddConstactsStateImpl _value,
      $Res Function(_$InitialAddConstactsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addContactStateModel = null,
  }) {
    return _then(_$InitialAddConstactsStateImpl(
      null == addContactStateModel
          ? _value.addContactStateModel
          : addContactStateModel // ignore: cast_nullable_to_non_nullable
              as AddContactStateModel,
    ));
  }
}

/// @nodoc

class _$InitialAddConstactsStateImpl
    with DiagnosticableTreeMixin
    implements InitialAddConstactsState {
  const _$InitialAddConstactsStateImpl(this.addContactStateModel);

  @override
  final AddContactStateModel addContactStateModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsStates.initial(addContactStateModel: $addContactStateModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddContactsStates.initial'))
      ..add(DiagnosticsProperty('addContactStateModel', addContactStateModel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialAddConstactsStateImpl &&
            (identical(other.addContactStateModel, addContactStateModel) ||
                other.addContactStateModel == addContactStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addContactStateModel);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialAddConstactsStateImplCopyWith<_$InitialAddConstactsStateImpl>
      get copyWith => __$$InitialAddConstactsStateImplCopyWithImpl<
          _$InitialAddConstactsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddContactStateModel addContactStateModel)
        initial,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadingAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        errorAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadedAddContactsState,
  }) {
    return initial(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddContactStateModel addContactStateModel)? initial,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
  }) {
    return initial?.call(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddContactStateModel addContactStateModel)? initial,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(addContactStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAddConstactsState value) initial,
    required TResult Function(LoadingAddContactsState value)
        loadingAddContactsState,
    required TResult Function(ErrorAddContactsState value)
        errorAddContactsState,
    required TResult Function(LoadedAddContactsState value)
        loadedAddContactsState,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAddConstactsState value)? initial,
    TResult? Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult? Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult? Function(LoadedAddContactsState value)? loadedAddContactsState,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAddConstactsState value)? initial,
    TResult Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult Function(LoadedAddContactsState value)? loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialAddConstactsState implements AddContactsStates {
  const factory InitialAddConstactsState(
          final AddContactStateModel addContactStateModel) =
      _$InitialAddConstactsStateImpl;

  @override
  AddContactStateModel get addContactStateModel;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialAddConstactsStateImplCopyWith<_$InitialAddConstactsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingAddContactsStateImplCopyWith<$Res>
    implements $AddContactsStatesCopyWith<$Res> {
  factory _$$LoadingAddContactsStateImplCopyWith(
          _$LoadingAddContactsStateImpl value,
          $Res Function(_$LoadingAddContactsStateImpl) then) =
      __$$LoadingAddContactsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddContactStateModel addContactStateModel});
}

/// @nodoc
class __$$LoadingAddContactsStateImplCopyWithImpl<$Res>
    extends _$AddContactsStatesCopyWithImpl<$Res, _$LoadingAddContactsStateImpl>
    implements _$$LoadingAddContactsStateImplCopyWith<$Res> {
  __$$LoadingAddContactsStateImplCopyWithImpl(
      _$LoadingAddContactsStateImpl _value,
      $Res Function(_$LoadingAddContactsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addContactStateModel = null,
  }) {
    return _then(_$LoadingAddContactsStateImpl(
      null == addContactStateModel
          ? _value.addContactStateModel
          : addContactStateModel // ignore: cast_nullable_to_non_nullable
              as AddContactStateModel,
    ));
  }
}

/// @nodoc

class _$LoadingAddContactsStateImpl
    with DiagnosticableTreeMixin
    implements LoadingAddContactsState {
  const _$LoadingAddContactsStateImpl(this.addContactStateModel);

  @override
  final AddContactStateModel addContactStateModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsStates.loadingAddContactsState(addContactStateModel: $addContactStateModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'AddContactsStates.loadingAddContactsState'))
      ..add(DiagnosticsProperty('addContactStateModel', addContactStateModel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingAddContactsStateImpl &&
            (identical(other.addContactStateModel, addContactStateModel) ||
                other.addContactStateModel == addContactStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addContactStateModel);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingAddContactsStateImplCopyWith<_$LoadingAddContactsStateImpl>
      get copyWith => __$$LoadingAddContactsStateImplCopyWithImpl<
          _$LoadingAddContactsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddContactStateModel addContactStateModel)
        initial,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadingAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        errorAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadedAddContactsState,
  }) {
    return loadingAddContactsState(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddContactStateModel addContactStateModel)? initial,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
  }) {
    return loadingAddContactsState?.call(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddContactStateModel addContactStateModel)? initial,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (loadingAddContactsState != null) {
      return loadingAddContactsState(addContactStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAddConstactsState value) initial,
    required TResult Function(LoadingAddContactsState value)
        loadingAddContactsState,
    required TResult Function(ErrorAddContactsState value)
        errorAddContactsState,
    required TResult Function(LoadedAddContactsState value)
        loadedAddContactsState,
  }) {
    return loadingAddContactsState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAddConstactsState value)? initial,
    TResult? Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult? Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult? Function(LoadedAddContactsState value)? loadedAddContactsState,
  }) {
    return loadingAddContactsState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAddConstactsState value)? initial,
    TResult Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult Function(LoadedAddContactsState value)? loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (loadingAddContactsState != null) {
      return loadingAddContactsState(this);
    }
    return orElse();
  }
}

abstract class LoadingAddContactsState implements AddContactsStates {
  const factory LoadingAddContactsState(
          final AddContactStateModel addContactStateModel) =
      _$LoadingAddContactsStateImpl;

  @override
  AddContactStateModel get addContactStateModel;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingAddContactsStateImplCopyWith<_$LoadingAddContactsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorAddContactsStateImplCopyWith<$Res>
    implements $AddContactsStatesCopyWith<$Res> {
  factory _$$ErrorAddContactsStateImplCopyWith(
          _$ErrorAddContactsStateImpl value,
          $Res Function(_$ErrorAddContactsStateImpl) then) =
      __$$ErrorAddContactsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddContactStateModel addContactStateModel});
}

/// @nodoc
class __$$ErrorAddContactsStateImplCopyWithImpl<$Res>
    extends _$AddContactsStatesCopyWithImpl<$Res, _$ErrorAddContactsStateImpl>
    implements _$$ErrorAddContactsStateImplCopyWith<$Res> {
  __$$ErrorAddContactsStateImplCopyWithImpl(_$ErrorAddContactsStateImpl _value,
      $Res Function(_$ErrorAddContactsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addContactStateModel = null,
  }) {
    return _then(_$ErrorAddContactsStateImpl(
      null == addContactStateModel
          ? _value.addContactStateModel
          : addContactStateModel // ignore: cast_nullable_to_non_nullable
              as AddContactStateModel,
    ));
  }
}

/// @nodoc

class _$ErrorAddContactsStateImpl
    with DiagnosticableTreeMixin
    implements ErrorAddContactsState {
  const _$ErrorAddContactsStateImpl(this.addContactStateModel);

  @override
  final AddContactStateModel addContactStateModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsStates.errorAddContactsState(addContactStateModel: $addContactStateModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'AddContactsStates.errorAddContactsState'))
      ..add(DiagnosticsProperty('addContactStateModel', addContactStateModel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorAddContactsStateImpl &&
            (identical(other.addContactStateModel, addContactStateModel) ||
                other.addContactStateModel == addContactStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addContactStateModel);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorAddContactsStateImplCopyWith<_$ErrorAddContactsStateImpl>
      get copyWith => __$$ErrorAddContactsStateImplCopyWithImpl<
          _$ErrorAddContactsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddContactStateModel addContactStateModel)
        initial,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadingAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        errorAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadedAddContactsState,
  }) {
    return errorAddContactsState(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddContactStateModel addContactStateModel)? initial,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
  }) {
    return errorAddContactsState?.call(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddContactStateModel addContactStateModel)? initial,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (errorAddContactsState != null) {
      return errorAddContactsState(addContactStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAddConstactsState value) initial,
    required TResult Function(LoadingAddContactsState value)
        loadingAddContactsState,
    required TResult Function(ErrorAddContactsState value)
        errorAddContactsState,
    required TResult Function(LoadedAddContactsState value)
        loadedAddContactsState,
  }) {
    return errorAddContactsState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAddConstactsState value)? initial,
    TResult? Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult? Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult? Function(LoadedAddContactsState value)? loadedAddContactsState,
  }) {
    return errorAddContactsState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAddConstactsState value)? initial,
    TResult Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult Function(LoadedAddContactsState value)? loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (errorAddContactsState != null) {
      return errorAddContactsState(this);
    }
    return orElse();
  }
}

abstract class ErrorAddContactsState implements AddContactsStates {
  const factory ErrorAddContactsState(
          final AddContactStateModel addContactStateModel) =
      _$ErrorAddContactsStateImpl;

  @override
  AddContactStateModel get addContactStateModel;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorAddContactsStateImplCopyWith<_$ErrorAddContactsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedAddContactsStateImplCopyWith<$Res>
    implements $AddContactsStatesCopyWith<$Res> {
  factory _$$LoadedAddContactsStateImplCopyWith(
          _$LoadedAddContactsStateImpl value,
          $Res Function(_$LoadedAddContactsStateImpl) then) =
      __$$LoadedAddContactsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddContactStateModel addContactStateModel});
}

/// @nodoc
class __$$LoadedAddContactsStateImplCopyWithImpl<$Res>
    extends _$AddContactsStatesCopyWithImpl<$Res, _$LoadedAddContactsStateImpl>
    implements _$$LoadedAddContactsStateImplCopyWith<$Res> {
  __$$LoadedAddContactsStateImplCopyWithImpl(
      _$LoadedAddContactsStateImpl _value,
      $Res Function(_$LoadedAddContactsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addContactStateModel = null,
  }) {
    return _then(_$LoadedAddContactsStateImpl(
      null == addContactStateModel
          ? _value.addContactStateModel
          : addContactStateModel // ignore: cast_nullable_to_non_nullable
              as AddContactStateModel,
    ));
  }
}

/// @nodoc

class _$LoadedAddContactsStateImpl
    with DiagnosticableTreeMixin
    implements LoadedAddContactsState {
  const _$LoadedAddContactsStateImpl(this.addContactStateModel);

  @override
  final AddContactStateModel addContactStateModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddContactsStates.loadedAddContactsState(addContactStateModel: $addContactStateModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'AddContactsStates.loadedAddContactsState'))
      ..add(DiagnosticsProperty('addContactStateModel', addContactStateModel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedAddContactsStateImpl &&
            (identical(other.addContactStateModel, addContactStateModel) ||
                other.addContactStateModel == addContactStateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addContactStateModel);

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedAddContactsStateImplCopyWith<_$LoadedAddContactsStateImpl>
      get copyWith => __$$LoadedAddContactsStateImplCopyWithImpl<
          _$LoadedAddContactsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddContactStateModel addContactStateModel)
        initial,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadingAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        errorAddContactsState,
    required TResult Function(AddContactStateModel addContactStateModel)
        loadedAddContactsState,
  }) {
    return loadedAddContactsState(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddContactStateModel addContactStateModel)? initial,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult? Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
  }) {
    return loadedAddContactsState?.call(addContactStateModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddContactStateModel addContactStateModel)? initial,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadingAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        errorAddContactsState,
    TResult Function(AddContactStateModel addContactStateModel)?
        loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (loadedAddContactsState != null) {
      return loadedAddContactsState(addContactStateModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAddConstactsState value) initial,
    required TResult Function(LoadingAddContactsState value)
        loadingAddContactsState,
    required TResult Function(ErrorAddContactsState value)
        errorAddContactsState,
    required TResult Function(LoadedAddContactsState value)
        loadedAddContactsState,
  }) {
    return loadedAddContactsState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAddConstactsState value)? initial,
    TResult? Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult? Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult? Function(LoadedAddContactsState value)? loadedAddContactsState,
  }) {
    return loadedAddContactsState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAddConstactsState value)? initial,
    TResult Function(LoadingAddContactsState value)? loadingAddContactsState,
    TResult Function(ErrorAddContactsState value)? errorAddContactsState,
    TResult Function(LoadedAddContactsState value)? loadedAddContactsState,
    required TResult orElse(),
  }) {
    if (loadedAddContactsState != null) {
      return loadedAddContactsState(this);
    }
    return orElse();
  }
}

abstract class LoadedAddContactsState implements AddContactsStates {
  const factory LoadedAddContactsState(
          final AddContactStateModel addContactStateModel) =
      _$LoadedAddContactsStateImpl;

  @override
  AddContactStateModel get addContactStateModel;

  /// Create a copy of AddContactsStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedAddContactsStateImplCopyWith<_$LoadedAddContactsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
