import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
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

// @immutable
// class InitMainCameraControllerEvent extends VideoChatFeatureEvents {
//   final CameraDescription cameraDescription;
//
//   const InitMainCameraControllerEvent(this.cameraDescription);
// }

@immutable
class StartVideoChatEvent extends VideoChatFeatureEvents {
  const StartVideoChatEvent();
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
class OnAddRemoteRendererStreamEvent extends VideoChatFeatureEvents {
  final MediaStream mediaStream;

  const OnAddRemoteRendererStreamEvent(this.mediaStream);
}

@immutable
class SwitchCameraStreamEvent extends VideoChatFeatureEvents {}

@immutable
class TurnMicOffAndOnEvent extends VideoChatFeatureEvents {
  final bool change;

  const TurnMicOffAndOnEvent({this.change = true});
}

@immutable
class TurnCameraOffAndEvent extends VideoChatFeatureEvents {}

// @immutable
// class VideoStreamHandlerEvent extends VideoChatFeatureEvents {
//   final ChannelReadEvent? pusherEvent;
//
//   const VideoStreamHandlerEvent(this.pusherEvent);
// }

// @immutable
// class AudioStreamHandlerEvent extends VideoChatFeatureEvents {
//   // temp for check
//   final Uint8List data;
//
//   const AudioStreamHandlerEvent(this.data);
// }
