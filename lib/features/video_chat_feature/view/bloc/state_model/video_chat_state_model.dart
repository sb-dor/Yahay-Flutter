import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:camera/camera.dart';

class VideoChatStateModel {
  VideoChatEntity? _videoChatEntity;

  VideoChatEntity? get videoChatEntity => _videoChatEntity;

  CameraController? _cameraController;

  CameraController? get cameraController => _cameraController;

  StreamSubscription<void>? _channelSubscription;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsClient? get pusherChannelClient => _pusherChannelsClient;

  void initVideoEntity(VideoChatEntity entity) {
    _videoChatEntity = entity;
  }

  void initCameraController(CameraController cameraController) {
    _cameraController = cameraController;
  }

  void initChannelSubscription(StreamSubscription channelSubs) {
    _channelSubscription = channelSubs;
  }

  void initPusherChannelClient(PusherChannelsClient pusherClient) {
    _pusherChannelsClient = pusherClient;
  }

  void dispose() async {
    await _cameraController?.dispose();
    await _channelSubscription?.cancel();
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    _cameraController = null;
    _channelSubscription = null;
    _pusherChannelsClient = null;
  }
}
