import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_functions.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/core/utils/extensions/extentions.dart';
import 'package:yahay/core/utils/talker/talker_service.dart';
import 'package:yahay/features/video_chat_feature/artc_signal_helper/webrtc_service.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:collection/collection.dart';

class VideoChatStateModel {
  final talker = TalkerService.instance.talker;

  WebRTCService? _webRTCService;

  WebRTCService? get webRTCService => _webRTCService;

  Future<void> initLocalAndRemoteRenderer() async {
    _webRTCService = WebRTCService();
    await _webRTCService?.initRenderer();
    await _webRTCService?.createOffer();
  }

  // CameraController? _mainVideoStreamCameraController;

  // CameraController? get mainVideoStreamCameraController => _mainVideoStreamCameraController;

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

  // already singleton
  // final FlutterSound _flutterSound = FlutterSound();

  // FlutterSound? get flutterSound => _flutterSound;

  // StreamSubscription<List<int>>? _audioStream;

  // StreamSubscription<List<int>>? get audioStream => _audioStream;

  Timer? _timerForGettingFrame;

  Timer? get timerForGettingFrame => _timerForGettingFrame;

  bool _chatStarted = false;

  bool get chatStarted => _chatStarted;

  void startChat() => _chatStarted = true;

  void finishChat() => _chatStarted = false;

  void initTimer(Timer timer) {
    _timerForGettingFrame = timer;
  }

  // Future<void> initMainCameraController(CameraController controller) async {
  //   _mainVideoStreamCameraController = controller;
  //   await _mainVideoStreamCameraController?.initialize();
  // }

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

  // void initAudioStreamSubscription(StreamSubscription<List<int>> subscription) {
  //   _audioStream = subscription;
  // }

  void initChannelChat(Chat? chat) {
    _chat = chat;
  }

  void initCurrentVideoChatEntity(VideoChatEntity entity) {
    _currentVideoChatEntity = entity;
  }

  void addUint8ImageDataToCurrentVideoChatEntity(Uint8List data) {
    // temp. if entity is null we will set new object to that entity
    _currentVideoChatEntity ??= VideoChatEntity(
      imageData: data,
      chat: _chat,
      user: _currentUser,
    );
    // update the image data
    _currentVideoChatEntity?.imageData = data;
  }

  void dispose() async {
    await _channelSubscription?.cancel();
    await _pusherChannelsClient?.disconnect();
    // await _mainVideoStreamCameraController?.dispose();
    // await _flutterSound.thePlayer.closePlayer();
    // await _audioStream?.cancel();
    await _webRTCService?.leaveChat();
    _pusherChannelsClient?.dispose();
    _channelSubscription = null;
    _pusherChannelsClient = null;
    for (var each in _videoChatEntities) {
      each.imageData = null;
    }
    _chat = null;
    finishChat();
  }
}
