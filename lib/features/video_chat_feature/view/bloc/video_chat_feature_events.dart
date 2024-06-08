import 'package:flutter/foundation.dart';

@immutable
class VideoChatFeatureEvents {
  const VideoChatFeatureEvents();
}

@immutable
class VideoChatInitFeatureEvent extends VideoChatFeatureEvents {
  final String channelName;

  const VideoChatInitFeatureEvent(this.channelName);
}
