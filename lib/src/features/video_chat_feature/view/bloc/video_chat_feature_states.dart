import 'package:flutter/foundation.dart';
import 'package:yahay/src/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';

@immutable
class VideoChatFeatureStates {
  final VideoChatStateModel videoChatStateModel;

  const VideoChatFeatureStates(this.videoChatStateModel);
}

@immutable
class InitialVideoChatState extends VideoChatFeatureStates {
  const InitialVideoChatState(super.videoChatStateModel);
}