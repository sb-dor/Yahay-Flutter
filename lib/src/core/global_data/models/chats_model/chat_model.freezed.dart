// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "chat_uuid")
  String? get uuid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "image_url")
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  String? get updatedAt => throw _privateConstructorUsedError; //
  @JsonKey(name: "chat_last_message")
  ChatMessageModel? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: "participants")
  List<ChatParticipantModel>? get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "messages")
  List<ChatMessageModel>? get messages => throw _privateConstructorUsedError;
  @JsonKey(name: "chat_video_room")
  RoomModel? get videoChatRoom => throw _privateConstructorUsedError;
  @JsonKey(
      name: "video_chat_streaming",
      includeFromJson: true,
      includeToJson: false,
      defaultValue: false,
      fromJson: _fromJsonVideoChatStreaming)
  bool? get videoChatStreaming => throw _privateConstructorUsedError;

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "chat_uuid") String? uuid,
      String? name,
      String? description,
      @JsonKey(name: "image_url") String? imageUrl,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
      @JsonKey(name: "participants") List<ChatParticipantModel>? participants,
      @JsonKey(name: "messages") List<ChatMessageModel>? messages,
      @JsonKey(name: "chat_video_room") RoomModel? videoChatRoom,
      @JsonKey(
          name: "video_chat_streaming",
          includeFromJson: true,
          includeToJson: false,
          defaultValue: false,
          fromJson: _fromJsonVideoChatStreaming)
      bool? videoChatStreaming});

  $ChatMessageModelCopyWith<$Res>? get lastMessage;
  $RoomModelCopyWith<$Res>? get videoChatRoom;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? participants = freezed,
    Object? messages = freezed,
    Object? videoChatRoom = freezed,
    Object? videoChatStreaming = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageModel?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatParticipantModel>?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>?,
      videoChatRoom: freezed == videoChatRoom
          ? _value.videoChatRoom
          : videoChatRoom // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
      videoChatStreaming: freezed == videoChatStreaming
          ? _value.videoChatStreaming
          : videoChatStreaming // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomModelCopyWith<$Res>? get videoChatRoom {
    if (_value.videoChatRoom == null) {
      return null;
    }

    return $RoomModelCopyWith<$Res>(_value.videoChatRoom!, (value) {
      return _then(_value.copyWith(videoChatRoom: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "chat_uuid") String? uuid,
      String? name,
      String? description,
      @JsonKey(name: "image_url") String? imageUrl,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "chat_last_message") ChatMessageModel? lastMessage,
      @JsonKey(name: "participants") List<ChatParticipantModel>? participants,
      @JsonKey(name: "messages") List<ChatMessageModel>? messages,
      @JsonKey(name: "chat_video_room") RoomModel? videoChatRoom,
      @JsonKey(
          name: "video_chat_streaming",
          includeFromJson: true,
          includeToJson: false,
          defaultValue: false,
          fromJson: _fromJsonVideoChatStreaming)
      bool? videoChatStreaming});

  @override
  $ChatMessageModelCopyWith<$Res>? get lastMessage;
  @override
  $RoomModelCopyWith<$Res>? get videoChatRoom;
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? participants = freezed,
    Object? messages = freezed,
    Object? videoChatRoom = freezed,
    Object? videoChatStreaming = freezed,
  }) {
    return _then(_$ChatModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageModel?,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatParticipantModel>?,
      messages: freezed == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>?,
      videoChatRoom: freezed == videoChatRoom
          ? _value.videoChatRoom
          : videoChatRoom // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
      videoChatStreaming: freezed == videoChatStreaming
          ? _value.videoChatStreaming
          : videoChatStreaming // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatModelImpl implements _ChatModel {
  const _$ChatModelImpl(
      {this.id,
      @JsonKey(name: "chat_uuid") this.uuid,
      this.name,
      this.description,
      @JsonKey(name: "image_url") this.imageUrl,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "chat_last_message") this.lastMessage,
      @JsonKey(name: "participants")
      final List<ChatParticipantModel>? participants,
      @JsonKey(name: "messages") final List<ChatMessageModel>? messages,
      @JsonKey(name: "chat_video_room") this.videoChatRoom,
      @JsonKey(
          name: "video_chat_streaming",
          includeFromJson: true,
          includeToJson: false,
          defaultValue: false,
          fromJson: _fromJsonVideoChatStreaming)
      this.videoChatStreaming})
      : _participants = participants,
        _messages = messages;

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: "chat_uuid")
  final String? uuid;
  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @override
  @JsonKey(name: "created_at")
  final String? createdAt;
  @override
  @JsonKey(name: "updated_at")
  final String? updatedAt;
//
  @override
  @JsonKey(name: "chat_last_message")
  final ChatMessageModel? lastMessage;
  final List<ChatParticipantModel>? _participants;
  @override
  @JsonKey(name: "participants")
  List<ChatParticipantModel>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ChatMessageModel>? _messages;
  @override
  @JsonKey(name: "messages")
  List<ChatMessageModel>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "chat_video_room")
  final RoomModel? videoChatRoom;
  @override
  @JsonKey(
      name: "video_chat_streaming",
      includeFromJson: true,
      includeToJson: false,
      defaultValue: false,
      fromJson: _fromJsonVideoChatStreaming)
  final bool? videoChatStreaming;

  @override
  String toString() {
    return 'ChatModel(id: $id, uuid: $uuid, name: $name, description: $description, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, lastMessage: $lastMessage, participants: $participants, messages: $messages, videoChatRoom: $videoChatRoom, videoChatStreaming: $videoChatStreaming)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.videoChatRoom, videoChatRoom) ||
                other.videoChatRoom == videoChatRoom) &&
            (identical(other.videoChatStreaming, videoChatStreaming) ||
                other.videoChatStreaming == videoChatStreaming));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uuid,
      name,
      description,
      imageUrl,
      createdAt,
      updatedAt,
      lastMessage,
      const DeepCollectionEquality().hash(_participants),
      const DeepCollectionEquality().hash(_messages),
      videoChatRoom,
      videoChatStreaming);

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {final int? id,
      @JsonKey(name: "chat_uuid") final String? uuid,
      final String? name,
      final String? description,
      @JsonKey(name: "image_url") final String? imageUrl,
      @JsonKey(name: "created_at") final String? createdAt,
      @JsonKey(name: "updated_at") final String? updatedAt,
      @JsonKey(name: "chat_last_message") final ChatMessageModel? lastMessage,
      @JsonKey(name: "participants")
      final List<ChatParticipantModel>? participants,
      @JsonKey(name: "messages") final List<ChatMessageModel>? messages,
      @JsonKey(name: "chat_video_room") final RoomModel? videoChatRoom,
      @JsonKey(
          name: "video_chat_streaming",
          includeFromJson: true,
          includeToJson: false,
          defaultValue: false,
          fromJson: _fromJsonVideoChatStreaming)
      final bool? videoChatStreaming}) = _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: "chat_uuid")
  String? get uuid;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(name: "image_url")
  String? get imageUrl;
  @override
  @JsonKey(name: "created_at")
  String? get createdAt;
  @override
  @JsonKey(name: "updated_at")
  String? get updatedAt; //
  @override
  @JsonKey(name: "chat_last_message")
  ChatMessageModel? get lastMessage;
  @override
  @JsonKey(name: "participants")
  List<ChatParticipantModel>? get participants;
  @override
  @JsonKey(name: "messages")
  List<ChatMessageModel>? get messages;
  @override
  @JsonKey(name: "chat_video_room")
  RoomModel? get videoChatRoom;
  @override
  @JsonKey(
      name: "video_chat_streaming",
      includeFromJson: true,
      includeToJson: false,
      defaultValue: false,
      fromJson: _fromJsonVideoChatStreaming)
  bool? get videoChatStreaming;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
