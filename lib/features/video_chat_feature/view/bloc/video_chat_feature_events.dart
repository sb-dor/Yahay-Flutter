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
class StartVideoChatEvent extends VideoChatFeatureEvents {
  // sending current abstract event in order to work with
  final Sink<VideoChatFeatureEvents> events;

  const StartVideoChatEvent(this.events);
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
