// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inner_candidate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InnerCandidateModel _$InnerCandidateModelFromJson(Map<String, dynamic> json) {
  return _InnerCandidateModel.fromJson(json);
}

/// @nodoc
mixin _$InnerCandidateModel {
  String get candidate => throw _privateConstructorUsedError;
  String get sdpMid => throw _privateConstructorUsedError;
  int get sdpMLineIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InnerCandidateModelCopyWith<InnerCandidateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InnerCandidateModelCopyWith<$Res> {
  factory $InnerCandidateModelCopyWith(
          InnerCandidateModel value, $Res Function(InnerCandidateModel) then) =
      _$InnerCandidateModelCopyWithImpl<$Res, InnerCandidateModel>;
  @useResult
  $Res call({String candidate, String sdpMid, int sdpMLineIndex});
}

/// @nodoc
class _$InnerCandidateModelCopyWithImpl<$Res, $Val extends InnerCandidateModel>
    implements $InnerCandidateModelCopyWith<$Res> {
  _$InnerCandidateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candidate = null,
    Object? sdpMid = null,
    Object? sdpMLineIndex = null,
  }) {
    return _then(_value.copyWith(
      candidate: null == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMid: null == sdpMid
          ? _value.sdpMid
          : sdpMid // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMLineIndex: null == sdpMLineIndex
          ? _value.sdpMLineIndex
          : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InnerCandidateModelImplCopyWith<$Res>
    implements $InnerCandidateModelCopyWith<$Res> {
  factory _$$InnerCandidateModelImplCopyWith(_$InnerCandidateModelImpl value,
          $Res Function(_$InnerCandidateModelImpl) then) =
      __$$InnerCandidateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String candidate, String sdpMid, int sdpMLineIndex});
}

/// @nodoc
class __$$InnerCandidateModelImplCopyWithImpl<$Res>
    extends _$InnerCandidateModelCopyWithImpl<$Res, _$InnerCandidateModelImpl>
    implements _$$InnerCandidateModelImplCopyWith<$Res> {
  __$$InnerCandidateModelImplCopyWithImpl(_$InnerCandidateModelImpl _value,
      $Res Function(_$InnerCandidateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candidate = null,
    Object? sdpMid = null,
    Object? sdpMLineIndex = null,
  }) {
    return _then(_$InnerCandidateModelImpl(
      candidate: null == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMid: null == sdpMid
          ? _value.sdpMid
          : sdpMid // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMLineIndex: null == sdpMLineIndex
          ? _value.sdpMLineIndex
          : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InnerCandidateModelImpl implements _InnerCandidateModel {
  const _$InnerCandidateModelImpl(
      {required this.candidate,
      required this.sdpMid,
      required this.sdpMLineIndex});

  factory _$InnerCandidateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InnerCandidateModelImplFromJson(json);

  @override
  final String candidate;
  @override
  final String sdpMid;
  @override
  final int sdpMLineIndex;

  @override
  String toString() {
    return 'InnerCandidateModel(candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InnerCandidateModelImpl &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate) &&
            (identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid) &&
            (identical(other.sdpMLineIndex, sdpMLineIndex) ||
                other.sdpMLineIndex == sdpMLineIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, candidate, sdpMid, sdpMLineIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InnerCandidateModelImplCopyWith<_$InnerCandidateModelImpl> get copyWith =>
      __$$InnerCandidateModelImplCopyWithImpl<_$InnerCandidateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InnerCandidateModelImplToJson(
      this,
    );
  }
}

abstract class _InnerCandidateModel implements InnerCandidateModel {
  const factory _InnerCandidateModel(
      {required final String candidate,
      required final String sdpMid,
      required final int sdpMLineIndex}) = _$InnerCandidateModelImpl;

  factory _InnerCandidateModel.fromJson(Map<String, dynamic> json) =
      _$InnerCandidateModelImpl.fromJson;

  @override
  String get candidate;
  @override
  String get sdpMid;
  @override
  int get sdpMLineIndex;
  @override
  @JsonKey(ignore: true)
  _$$InnerCandidateModelImplCopyWith<_$InnerCandidateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
