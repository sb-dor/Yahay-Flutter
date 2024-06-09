import 'dart:async';
import 'dart:collection';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/features/video_chat_feature/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:camera/camera.dart';
import 'package:yahay/injections/injections.dart';

class VideoChatStateModel {
  final cameraService = snoopy<CameraHelperService>();

  String? _channelName;

  String? get channelName => _channelName;

  final List<VideoChatEntity> _videoChatEntities = [];

  UnmodifiableListView<VideoChatEntity> get cameraControllers =>
      UnmodifiableListView(_videoChatEntities);

  StreamSubscription<void>? _channelSubscription;

  StreamSubscription<void>? get channelSubscription => _channelSubscription;

  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsClient? get pusherChannelClient => _pusherChannelsClient;

  VideoChatEntity? get currentVideoChat => _videoChatEntities.firstOrNull;

  void addVideoChat(VideoChatEntity videoChatEntity) {
    _videoChatEntities.add(videoChatEntity);
  }

  void initChannelSubscription(StreamSubscription<void>? channelSubs) {
    _channelSubscription = channelSubs;
  }

  void initPusherChannelClient(PusherChannelsClient pusherClient) {
    _pusherChannelsClient = pusherClient;
  }

  void initChannelName(String channelName) {
    _channelName = channelName;
  }

  void dispose() async {
    await _channelSubscription?.cancel();
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    _channelSubscription = null;
    _pusherChannelsClient = null;
    for (var each in _videoChatEntities) {
      await each.cameraController.dispose();
    }
    _videoChatEntities.clear();
    _channelName = null;
  }
}
