import 'package:camera/camera.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';

@immutable
class VideoChatFeatureEvents {
  const VideoChatFeatureEvents();
}

@immutable
class VideoChatInitFeatureEvent extends VideoChatFeatureEvents {
  final Chat? chat;

  const VideoChatInitFeatureEvent(this.chat);
}

@immutable
class InitMainCameraControllerEvent extends VideoChatFeatureEvents {
  final CameraDescription cameraDescription;

  const InitMainCameraControllerEvent(this.cameraDescription);
}

@immutable
class StartVideoChatEvent extends VideoChatFeatureEvents {
  // sending current abstract event in order to work with
  final bool makeRequestToServer;

  const StartVideoChatEvent({this.makeRequestToServer = true});
}

@immutable
class VideoChatEntranceEvent extends VideoChatFeatureEvents {
  const VideoChatEntranceEvent();
}

@immutable
class FinishVideoChatEvent extends VideoChatFeatureEvents {
  const FinishVideoChatEvent();
}

@immutable
class VideoStreamHandlerEvent extends VideoChatFeatureEvents {
  final ChannelReadEvent? pusherEvent;

  const VideoStreamHandlerEvent(this.pusherEvent);
}

@immutable
class AudioStreamHandlerEvent extends VideoChatFeatureEvents {
  // temp for check
  final Uint8List data;

  const AudioStreamHandlerEvent(this.data);
}
