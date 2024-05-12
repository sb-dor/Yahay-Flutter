// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_participant_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatParticipantStatusModel _$ChatParticipantStatusModelFromJson(
    Map<String, dynamic> json) {
  return _ChatParticipantStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ChatParticipantStatusModel {
  int? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatParticipantStatusModelCopyWith<ChatParticipantStatusModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatParticipantStatusModelCopyWith<$Res> {
  factory $ChatParticipantStatusModelCopyWith(ChatParticipantStatusModel value,
          $Res Function(ChatParticipantStatusModel) then) =
      _$ChatParticipantStatusModelCopyWithImpl<$Res,
          ChatParticipantStatusModel>;
  @useResult
  $Res call({int? id, String? status});
}

/// @nodoc
class _$ChatParticipantStatusModelCopyWithImpl<$Res,
        $Val extends ChatParticipantStatusModel>
    implements $ChatParticipantStatusModelCopyWith<$Res> {
  _$ChatParticipantStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatParticipantStatusModelImplCopyWith<$Res>
    implements $ChatParticipantStatusModelCopyWith<$Res> {
  factory _$$ChatParticipantStatusModelImplCopyWith(
          _$ChatParticipantStatusModelImpl value,
          $Res Function(_$ChatParticipantStatusModelImpl) then) =
      __$$ChatParticipantStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? status});
}

/// @nodoc
class __$$ChatParticipantStatusModelImplCopyWithImpl<$Res>
    extends _$ChatParticipantStatusModelCopyWithImpl<$Res,
        _$ChatParticipantStatusModelImpl>
    implements _$$ChatParticipantStatusModelImplCopyWith<$Res> {
  __$$ChatParticipantStatusModelImplCopyWithImpl(
      _$ChatParticipantStatusModelImpl _value,
      $Res Function(_$ChatParticipantStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
  }) {
    return _then(_$ChatParticipantStatusModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatParticipantStatusModelImpl implements _ChatParticipantStatusModel {
  const _$ChatParticipantStatusModelImpl({this.id, this.status});

  factory _$ChatParticipantStatusModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatParticipantStatusModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? status;

  @override
  String toString() {
    return 'ChatParticipantStatusModel(id: $id, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatParticipantStatusModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatParticipantStatusModelImplCopyWith<_$ChatParticipantStatusModelImpl>
      get copyWith => __$$ChatParticipantStatusModelImplCopyWithImpl<
          _$ChatParticipantStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatParticipantStatusModelImplToJson(
      this,
    );
  }
}

abstract class _ChatParticipantStatusModel
    implements ChatParticipantStatusModel {
  const factory _ChatParticipantStatusModel(
      {final int? id, final String? status}) = _$ChatParticipantStatusModelImpl;

  factory _ChatParticipantStatusModel.fromJson(Map<String, dynamic> json) =
      _$ChatParticipantStatusModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$ChatParticipantStatusModelImplCopyWith<_$ChatParticipantStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
