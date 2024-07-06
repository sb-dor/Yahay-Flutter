import 'dart:async';
import 'dart:collection';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_functions.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/core/utils/extensions/extentions.dart';
import 'package:yahay/core/utils/talker/talker_service.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:collection/collection.dart';
import 'package:yahay/features/video_chat_feature/webrtc_helper/webrtc_laravel_helper.dart';
import 'package:yahay/injections/injections.dart';

class VideoChatStateModel {
  final talker = TalkerService.instance.talker;

  UnmodifiableListView<VideoChatEntity> get videoChatEntities =>
      UnmodifiableListView(_videoChatEntities);

  StreamSubscription<void>? _channelSubscription;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsClient? get pusherChannelClient => _pusherChannelsClient;

  Timer? _timerForGettingFrame;

  Timer? get timerForGettingFrame => _timerForGettingFrame;

  bool _chatStarted = false;

  bool get chatStarted => _chatStarted;

  bool _hasAudio = true;

  bool _hasVideo = true;

  bool get hasAudio => _hasAudio;

  bool get hasVideo => _hasVideo;

  Chat? _chat;

  Chat? get chat => _chat;

  ChatModel? get chatModel => ChatModel.fromEntity(_chat);

  ChatFunctions? get chatFunctions => ChatFunctions.fromEntity(_chat);

  User? _currentUser;

  User? get currentUser => _currentUser;

  UserModel? get currentUserModel => UserModel.fromEntity(_currentUser);

  VideoChatEntity? _currentVideoChatEntity;

  VideoChatEntity? get currentVideoChatEntity => _currentVideoChatEntity;

  final List<VideoChatEntity> _videoChatEntities = [];

  WebrtcLaravelHelper? _webrtcLaravelHelper;

  WebrtcLaravelHelper? get webrtcLaravelHelper => _webrtcLaravelHelper;

  Future<void> initLocalRenderer() async {
    // helper initialization first
    _webrtcLaravelHelper = WebrtcLaravelHelper();

    _currentVideoChatEntity = VideoChatEntity(
      videoRenderer: RTCVideoRenderer(),
      chat: _chat,
      user: _currentUser,
    );

    // init the video renderer
    await _currentVideoChatEntity?.videoRenderer?.initialize();

    // after video render initialization open the media
    await _webrtcLaravelHelper?.openUserMedia(_currentVideoChatEntity!.videoRenderer!);
  }

  void startChat() => _chatStarted = true;

  void finishChat() => _chatStarted = false;

  void initTimer(Timer timer) {
    _timerForGettingFrame = timer;
  }

  void addVideoChat(VideoChatEntity videoChatEntity) {
    _videoChatEntities.add(videoChatEntity);
  }

  void updateVideoChat(VideoChatEntity videoChatEntity, int index) {
    _videoChatEntities[index] = videoChatEntity;
  }

  void checkVideoEntitiesBeforeAdding(VideoChatEntity videoChatEntity) {
    final videoEntity = _videoChatEntities.getValueAndIndexOrNull((element) =>
        element.chat?.uuid == videoChatEntity.chat?.uuid &&
        element.user?.id == videoChatEntity.user?.id);
    if (videoEntity == null) {
      addVideoChat(videoChatEntity);
    } else {
      updateVideoChat(videoChatEntity, videoEntity.$2);
    }
  }

  void initCurrentUser(User? user) => _currentUser = user;

  void initChannelSubscription(StreamSubscription<void>? channelSubs) {
    _channelSubscription = channelSubs;
  }

  void initPusherChannelClient(PusherChannelsClient pusherClient) {
    _pusherChannelsClient = pusherClient;
  }

  void initChannelChat(Chat? chat) {
    _chat = ChatModel.fromEntity(chat)?.copyWith();
  }

  void changeHasAudio({bool? value}) => _hasAudio = value ?? !_hasAudio;

  void changeHasVideo({bool? value}) => _hasVideo = value ?? !_hasVideo;

  Future<void> dispose() async {
    await _channelSubscription?.cancel();
    await _pusherChannelsClient?.disconnect();
    if (_currentVideoChatEntity?.videoRenderer != null) {
      await _webrtcLaravelHelper?.hangUp(_currentVideoChatEntity!.videoRenderer!);
    }
    _webrtcLaravelHelper = null;
    _currentVideoChatEntity = null;
    _pusherChannelsClient?.dispose();
    _channelSubscription = null;
    _pusherChannelsClient = null;
    for (var each in _videoChatEntities) {
      await each.videoRenderer?.dispose();
      each.videoRenderer = null;
    }
    _videoChatEntities.clear();
    _chat = null;
    finishChat();
  }
}
