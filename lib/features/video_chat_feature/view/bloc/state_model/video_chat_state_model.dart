import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_functions.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/features/video_chat_feature/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/injections/injections.dart';

class VideoChatStateModel {
  final cameraService = snoopy<CameraHelperService>();

  CameraController? _mainVideoStreamCameraController;

  CameraController? get mainVideoStreamCameraController => _mainVideoStreamCameraController;

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

  UnmodifiableListView<VideoChatEntity> get videoChatEntities =>
      UnmodifiableListView(_videoChatEntities);

  StreamSubscription<void>? _channelSubscription;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsClient? get pusherChannelClient => _pusherChannelsClient;

  Timer? _timerForGettingFrame;

  Timer? get timerForGettingFrame => _timerForGettingFrame;

  void initTimer(Timer timer) {
    _timerForGettingFrame = timer;
  }

  Future<void> initMainCameraController(CameraController controller) async {
    _mainVideoStreamCameraController = controller;
    await _mainVideoStreamCameraController?.initialize();
  }

  void addVideoChat(VideoChatEntity videoChatEntity) {
    _videoChatEntities.add(videoChatEntity);
  }

  void initCurrentUser(User? user) => _currentUser = user;

  void initChannelSubscription(StreamSubscription<void>? channelSubs) {
    _channelSubscription = channelSubs;
  }

  void initPusherChannelClient(PusherChannelsClient pusherClient) {
    _pusherChannelsClient = pusherClient;
  }

  void initChannelChat(Chat? chat) {
    _chat = chat;
  }

  void initCurrentVideoChatEntity(VideoChatEntity entity) {
    _currentVideoChatEntity = entity;
  }

  void dispose() async {
    await _channelSubscription?.cancel();
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    _channelSubscription = null;
    _pusherChannelsClient = null;
    for (var each in _videoChatEntities) {
      each.imageData = null;
    }
    _mainVideoStreamCameraController?.dispose();
    _videoChatEntities.clear();
    _chat = null;
  }
}
