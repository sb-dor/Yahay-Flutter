import 'package:flutter/foundation.dart';
import 'package:yahay/features/chats/view/bloc/state_model/chats_state_model.dart';

@immutable
class ChatsStates {
  final ChatsStateModel chatsStateModel;

  const ChatsStates(this.chatsStateModel);
}

@immutable
class LoadingChatsState extends ChatsStates {
  const LoadingChatsState(super.chatsStateModel);
}

@immutable
class ErrorChatsState extends ChatsStates {
  const ErrorChatsState(super.chatsStateModel);
}

@immutable
class LoadedChatsState extends ChatsStates {
  const LoadedChatsState(super.chatsStateModel);
}
