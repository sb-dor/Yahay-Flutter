import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/features/chats/view/bloc/state_model/chats_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'chats_events.dart';
import 'chats_states.dart';

typedef PusherDataListener = void Function(
    String eventName, void Function(PusherEvent? event) onEvent);

@immutable
class ChatsBloc {
  static late BehaviorSubject<ChatsStates> _currentState; // is necessary if you use _emitter()
  static late ChatsStateModel _currentStateModel;

  final Sink<ChatsEvents> events;
  final BehaviorSubject<ChatsStates> _states;

  BehaviorSubject<ChatsStates> get states => _states;

  const ChatsBloc._({
    required this.events,
    required final BehaviorSubject<ChatsStates> states,
  }) : _states = states;

  factory ChatsBloc({
    required ChatsRepo chatsRepo,
  }) {
    _currentStateModel = ChatsStateModel();

    final chatsEventsBehavior = BehaviorSubject<ChatsEvents>();

    final chatsEventsStates = chatsEventsBehavior.switchMap<ChatsStates>((event) async* {
      Stream<ChatsStates> state = Stream.value(LoadingChatsState(_currentStateModel));

      if (event is ChatListenerEvent) {
        state = _chatListenerEvent(event);
      }

      yield* state;
    }).startWith(LoadingChatsState(_currentStateModel));

    final BehaviorSubject<ChatsStates> behaviorOfStates = BehaviorSubject<ChatsStates>()
      ..addStream(chatsEventsStates);

    _currentState = behaviorOfStates;

    //
    //
    // for channel listening (for getting new chats when whoever writes)
    final user = snoopy<AuthBloc>().states.value.authStateModel.user;

    final channelName = "${Constants.channelNotifyOfUserName}${user?.id}";

    final chatChannel = snoopy<PusherClientService>().pusherClient.subscribe(channelName);

    chatChannel.bind(Constants.channelNotifyOfUserEventName, (pusherData) {
      chatsEventsBehavior.add(ChatListenerEvent(pusherData));
    });
    //

    return ChatsBloc._(
      events: chatsEventsBehavior.sink,
      states: behaviorOfStates,
    );
  }

  static Stream<ChatsStates> _chatListenerEvent(ChatListenerEvent event) async* {
    try {
      debugPrint("coming data from event is: ${event.event?.data}");

      yield* _emitter();
    } catch (e) {
      debugPrint("_channelListenerEvent error is: $e");
    }
  }

  static Stream<ChatsStates> _emitter() async* {
    if (_currentState.value is LoadingChatsState) {
      yield LoadingChatsState(_currentStateModel);
    } else if (_currentState.value is ErrorChatsState) {
      yield ErrorChatsState(_currentStateModel);
    } else if (_currentState is LoadedChatsState) {
      yield LoadedChatsState(_currentStateModel);
    }
  }
}
