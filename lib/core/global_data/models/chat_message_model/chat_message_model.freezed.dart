// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) {
  return _ChatMessageModel.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageModel {
  int? get id => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  @JsonKey(name: "related_to_user")
  UserModel? get relatedToUser => throw _privateConstructorUsedError;
  ChatModel? get chat => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: "chat_message_uuid")
  String? get chatMessageUUID => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file => throw _privateConstructorUsedError;
  @JsonKey(name: "image_url")
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "video_url")
  String? get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "deleted_at")
  String? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? get messageSent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageModelCopyWith<ChatMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageModelCopyWith<$Res> {
  factory $ChatMessageModelCopyWith(
          ChatMessageModel value, $Res Function(ChatMessageModel) then) =
      _$ChatMessageModelCopyWithImpl<$Res, ChatMessageModel>;
  @useResult
  $Res call(
      {int? id,
      UserModel? user,
      @JsonKey(name: "related_to_user") UserModel? relatedToUser,
      ChatModel? chat,
      String? message,
      @JsonKey(name: "chat_message_uuid") String? chatMessageUUID,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file,
      @JsonKey(name: "image_url") String? imageUrl,
      @JsonKey(name: "video_url") String? videoUrl,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "deleted_at") String? deletedAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      bool? messageSent});

  $UserModelCopyWith<$Res>? get user;
  $UserModelCopyWith<$Res>? get relatedToUser;
  $ChatModelCopyWith<$Res>? get chat;
}

/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res, $Val extends ChatMessageModel>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? relatedToUser = freezed,
    Object? chat = freezed,
    Object? message = freezed,
    Object? chatMessageUUID = freezed,
    Object? file = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? messageSent = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      relatedToUser: freezed == relatedToUser
          ? _value.relatedToUser
          : relatedToUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      chatMessageUUID: freezed == chatMessageUUID
          ? _value.chatMessageUUID
          : chatMessageUUID // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      messageSent: freezed == messageSent
          ? _value.messageSent
          : messageSent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get relatedToUser {
    if (_value.relatedToUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.relatedToUser!, (value) {
      return _then(_value.copyWith(relatedToUser: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatModelCopyWith<$Res>? get chat {
    if (_value.chat == null) {
      return null;
    }

    return $ChatModelCopyWith<$Res>(_value.chat!, (value) {
      return _then(_value.copyWith(chat: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageModelImplCopyWith<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  factory _$$ChatMessageModelImplCopyWith(_$ChatMessageModelImpl value,
          $Res Function(_$ChatMessageModelImpl) then) =
      __$$ChatMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      UserModel? user,
      @JsonKey(name: "related_to_user") UserModel? relatedToUser,
      ChatModel? chat,
      String? message,
      @JsonKey(name: "chat_message_uuid") String? chatMessageUUID,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file,
      @JsonKey(name: "image_url") String? imageUrl,
      @JsonKey(name: "video_url") String? videoUrl,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "deleted_at") String? deletedAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      bool? messageSent});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $UserModelCopyWith<$Res>? get relatedToUser;
  @override
  $ChatModelCopyWith<$Res>? get chat;
}

/// @nodoc
class __$$ChatMessageModelImplCopyWithImpl<$Res>
    extends _$ChatMessageModelCopyWithImpl<$Res, _$ChatMessageModelImpl>
    implements _$$ChatMessageModelImplCopyWith<$Res> {
  __$$ChatMessageModelImplCopyWithImpl(_$ChatMessageModelImpl _value,
      $Res Function(_$ChatMessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? relatedToUser = freezed,
    Object? chat = freezed,
    Object? message = freezed,
    Object? chatMessageUUID = freezed,
    Object? file = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? messageSent = freezed,
  }) {
    return _then(_$ChatMessageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      relatedToUser: freezed == relatedToUser
          ? _value.relatedToUser
          : relatedToUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      chatMessageUUID: freezed == chatMessageUUID
          ? _value.chatMessageUUID
          : chatMessageUUID // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      messageSent: freezed == messageSent
          ? _value.messageSent
          : messageSent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageModelImpl implements _ChatMessageModel {
  const _$ChatMessageModelImpl(
      {this.id,
      this.user,
      @JsonKey(name: "related_to_user") this.relatedToUser,
      this.chat,
      this.message,
      @JsonKey(name: "chat_message_uuid") this.chatMessageUUID,
      @JsonKey(includeFromJson: false, includeToJson: false) this.file,
      @JsonKey(name: "image_url") this.imageUrl,
      @JsonKey(name: "video_url") this.videoUrl,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "deleted_at") this.deletedAt,
      @JsonKey(includeToJson: false, includeFromJson: false) this.messageSent});

  factory _$ChatMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageModelImplFromJson(json);

  @override
  final int? id;
  @override
  final UserModel? user;
  @override
  @JsonKey(name: "related_to_user")
  final UserModel? relatedToUser;
  @override
  final ChatModel? chat;
  @override
  final String? message;
  @override
  @JsonKey(name: "chat_message_uuid")
  final String? chatMessageUUID;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? file;
  @override
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @override
  @JsonKey(name: "video_url")
  final String? videoUrl;
  @override
  @JsonKey(name: "created_at")
  final String? createdAt;
  @override
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @override
  @JsonKey(name: "deleted_at")
  final String? deletedAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final bool? messageSent;

  @override
  String toString() {
    return 'ChatMessageModel(id: $id, user: $user, relatedToUser: $relatedToUser, chat: $chat, message: $message, chatMessageUUID: $chatMessageUUID, file: $file, imageUrl: $imageUrl, videoUrl: $videoUrl, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, messageSent: $messageSent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.relatedToUser, relatedToUser) ||
                other.relatedToUser == relatedToUser) &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.chatMessageUUID, chatMessageUUID) ||
                other.chatMessageUUID == chatMessageUUID) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.messageSent, messageSent) ||
                other.messageSent == messageSent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user,
      relatedToUser,
      chat,
      message,
      chatMessageUUID,
      file,
      imageUrl,
      videoUrl,
      createdAt,
      updatedAt,
      deletedAt,
      messageSent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageModelImplCopyWith<_$ChatMessageModelImpl> get copyWith =>
      __$$ChatMessageModelImplCopyWithImpl<_$ChatMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageModelImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageModel implements ChatMessageModel {
  const factory _ChatMessageModel(
      {final int? id,
      final UserModel? user,
      @JsonKey(name: "related_to_user") final UserModel? relatedToUser,
      final ChatModel? chat,
      final String? message,
      @JsonKey(name: "chat_message_uuid") final String? chatMessageUUID,
      @JsonKey(includeFromJson: false, includeToJson: false) final File? file,
      @JsonKey(name: "image_url") final String? imageUrl,
      @JsonKey(name: "video_url") final String? videoUrl,
      @JsonKey(name: "created_at") final String? createdAt,
      @JsonKey(name: "updated_at") final String? updatedAt,
      @JsonKey(name: "deleted_at") final String? deletedAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final bool? messageSent}) = _$ChatMessageModelImpl;

  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) =
      _$ChatMessageModelImpl.fromJson;

  @override
  int? get id;
  @override
  UserModel? get user;
  @override
  @JsonKey(name: "related_to_user")
  UserModel? get relatedToUser;
  @override
  ChatModel? get chat;
  @override
  String? get message;
  @override
  @JsonKey(name: "chat_message_uuid")
  String? get chatMessageUUID;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file;
  @override
  @JsonKey(name: "image_url")
  String? get imageUrl;
  @override
  @JsonKey(name: "video_url")
  String? get videoUrl;
  @override
  @JsonKey(name: "created_at")
  String? get createdAt;
  @override
  @JsonKey(name: "updated_at")
  String? get updatedAt;
  @override
  @JsonKey(name: "deleted_at")
  String? get deletedAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? get messageSent;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageModelImplCopyWith<_$ChatMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
