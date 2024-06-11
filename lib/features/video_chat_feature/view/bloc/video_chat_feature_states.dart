import 'package:flutter/foundation.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';

@immutable
class VideoChatFeatureStates {
  final VideoChatStateModel videoChatStateModel;

  const VideoChatFeatureStates(this.videoChatStateModel);
}

@immutable
class InitialVideoChatState extends VideoChatFeatureStates {
  const InitialVideoChatState(super.videoChatStateModel);
}

@immutable
class LoadingVideoChatState extends VideoChatFeatureStates {
  const LoadingVideoChatState(super.videoChatStateModel);
}

@immutable
class ErrorVideoChatState extends VideoChatFeatureStates {
  const ErrorVideoChatState(super.videoChatStateModel);
}
