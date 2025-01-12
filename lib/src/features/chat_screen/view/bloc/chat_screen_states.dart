import 'package:flutter/foundation.dart';

import 'state_model/chat_screen_state_model.dart';

@immutable
class ChatScreenStates {
  final ChatScreenStateModel chatScreenStateModel;

  const ChatScreenStates(this.chatScreenStateModel);
}

@immutable
class LoadingChatScreenState extends ChatScreenStates {
  const LoadingChatScreenState(super.chatScreenStateModel);
}

@immutable
class ErrorChatScreenState extends ChatScreenStates {
  const ErrorChatScreenState(super.chatScreenStateModel);
}

@immutable
class LoadedChatScreenState extends ChatScreenStates {
  const LoadedChatScreenState(super.chatScreenStateModel);
}
