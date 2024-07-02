// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CandidateModel _$CandidateModelFromJson(Map<String, dynamic> json) {
  return _CandidateModel.fromJson(json);
}

/// @nodoc
mixin _$CandidateModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "room_id")
  int? get roomId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromJsonInnerCandidate)
  InnerCandidateModel? get candidate => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CandidateModelCopyWith<CandidateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandidateModelCopyWith<$Res> {
  factory $CandidateModelCopyWith(
          CandidateModel value, $Res Function(CandidateModel) then) =
      _$CandidateModelCopyWithImpl<$Res, CandidateModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "room_id") int? roomId,
      @JsonKey(fromJson: _fromJsonInnerCandidate)
      InnerCandidateModel? candidate,
      String? role,
      DateTime? createdAt,
      DateTime? updatedAt});

  $InnerCandidateModelCopyWith<$Res>? get candidate;
}

/// @nodoc
class _$CandidateModelCopyWithImpl<$Res, $Val extends CandidateModel>
    implements $CandidateModelCopyWith<$Res> {
  _$CandidateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roomId = freezed,
    Object? candidate = freezed,
    Object? role = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      candidate: freezed == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as InnerCandidateModel?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InnerCandidateModelCopyWith<$Res>? get candidate {
    if (_value.candidate == null) {
      return null;
    }

    return $InnerCandidateModelCopyWith<$Res>(_value.candidate!, (value) {
      return _then(_value.copyWith(candidate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CandidateModelImplCopyWith<$Res>
    implements $CandidateModelCopyWith<$Res> {
  factory _$$CandidateModelImplCopyWith(_$CandidateModelImpl value,
          $Res Function(_$CandidateModelImpl) then) =
      __$$CandidateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "room_id") int? roomId,
      @JsonKey(fromJson: _fromJsonInnerCandidate)
      InnerCandidateModel? candidate,
      String? role,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $InnerCandidateModelCopyWith<$Res>? get candidate;
}

/// @nodoc
class __$$CandidateModelImplCopyWithImpl<$Res>
    extends _$CandidateModelCopyWithImpl<$Res, _$CandidateModelImpl>
    implements _$$CandidateModelImplCopyWith<$Res> {
  __$$CandidateModelImplCopyWithImpl(
      _$CandidateModelImpl _value, $Res Function(_$CandidateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roomId = freezed,
    Object? candidate = freezed,
    Object? role = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CandidateModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      candidate: freezed == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as InnerCandidateModel?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandidateModelImpl implements _CandidateModel {
  const _$CandidateModelImpl(
      {required this.id,
      @JsonKey(name: "room_id") required this.roomId,
      @JsonKey(fromJson: _fromJsonInnerCandidate) required this.candidate,
      required this.role,
      required this.createdAt,
      required this.updatedAt});

  factory _$CandidateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandidateModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: "room_id")
  final int? roomId;
  @override
  @JsonKey(fromJson: _fromJsonInnerCandidate)
  final InnerCandidateModel? candidate;
  @override
  final String? role;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CandidateModel(id: $id, roomId: $roomId, candidate: $candidate, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandidateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, roomId, candidate, role, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CandidateModelImplCopyWith<_$CandidateModelImpl> get copyWith =>
      __$$CandidateModelImplCopyWithImpl<_$CandidateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandidateModelImplToJson(
      this,
    );
  }
}

abstract class _CandidateModel implements CandidateModel {
  const factory _CandidateModel(
      {required final int? id,
      @JsonKey(name: "room_id") required final int? roomId,
      @JsonKey(fromJson: _fromJsonInnerCandidate)
      required final InnerCandidateModel? candidate,
      required final String? role,
      required final DateTime? createdAt,
      required final DateTime? updatedAt}) = _$CandidateModelImpl;

  factory _CandidateModel.fromJson(Map<String, dynamic> json) =
      _$CandidateModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: "room_id")
  int? get roomId;
  @override
  @JsonKey(fromJson: _fromJsonInnerCandidate)
  InnerCandidateModel? get candidate;
  @override
  String? get role;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CandidateModelImplCopyWith<_$CandidateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
