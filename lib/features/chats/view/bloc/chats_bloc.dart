import 'dart:async';
import 'dart:convert';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talker/talker.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/core/utils/talker/talker_service.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/features/chats/domain/usecases/get_user_chats_usecase.dart';
import 'package:yahay/features/chats/view/bloc/state_model/chats_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'chats_events.dart';
import 'chats_states.dart';

// typedef PusherDataListener = void Function(
//     String eventName, void Function(PusherEvent? event) onEvent);

@immutable
class ChatsBloc {
  static late BehaviorSubject<ChatsStates> _currentState; // is necessary if you use _emitter()
  static late ChatsStateModel _currentStateModel;
  static late GetUserChatsUseCase _getUserChatsUseCase;

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
    _getUserChatsUseCase = GetUserChatsUseCase(chatsRepo);

    final chatsEventsBehavior = BehaviorSubject<ChatsEvents>();

    final chatsEventsStates = chatsEventsBehavior.flatMap<ChatsStates>((event) async* {
      if (event is ChatListenerEvent) {
        yield* _chatListenerEvent(event);
      } else if (event is ChatListenerInitEvent) {
        yield* _chatListenerInitEvent(event);
      } else if (event is GetUserChatsEvent) {
        yield* _getUserChatsEvent(event);
      } else if (event is ChangeToLoadingState) {
        yield* _changeToLoadingState(event);
      }
    }).startWith(LoadingChatsState(_currentStateModel));

    final BehaviorSubject<ChatsStates> behaviorOfStates = BehaviorSubject<ChatsStates>()
      ..addStream(chatsEventsStates);

    _currentState = behaviorOfStates;

    return ChatsBloc._(
      events: chatsEventsBehavior.sink,
      states: behaviorOfStates,
    );
  }

  // for channel listening (for getting new chats when whoever writes)
  static Stream<ChatsStates> _chatListenerInitEvent(ChatListenerInitEvent event) async* {
    try {
      final user = snoopy<AuthBloc>().states.value.authStateModel.user;

      final channelName = "${Constants.channelNotifyOfUserName}${user?.id}";

      debugPrint("current whole channel listeners: $channelName");

      _currentStateModel.setToPusherClient(
        PusherChannelsClient.websocket(
          options: snoopy<PusherClientService>().options,
          connectionErrorHandler: (f, s, t) {},
        ),
      );

      final chatChannel = _currentStateModel.pusherClientService?.publicChannel(channelName);

      final subs = _currentStateModel.pusherClientService?.onConnectionEstablished.listen((e) {
        chatChannel?.subscribeIfNotUnsubscribed();
      });

      _currentStateModel.setToSubscription(subs);

      await _currentStateModel.pusherClientService?.connect();

      chatChannel?.bind(Constants.channelNotifyOfUserEventName).listen((pusherData) {
        event.events.add(ChatListenerEvent(pusherData));
      });
    } catch (e) {
      debugPrint("current whole channel listeners error is: $e");
    }
  }

  static Stream<ChatsStates> _getUserChatsEvent(GetUserChatsEvent event) async* {
    try {
      if (_currentState.value is LoadedChatsState && !event.refresh) return;

      yield LoadingChatsState(_currentStateModel);

      _currentStateModel.setChat(await _getUserChatsUseCase.chats());

      debugPrint("chat length is: ${_currentStateModel.chats.length}");

      yield LoadedChatsState(_currentStateModel);
    } catch (e) {
      debugPrint("_getUserChatsEvent error is: $e");
      yield ErrorChatsState(_currentStateModel);
    }
  }

  static Stream<ChatsStates> _chatListenerEvent(ChatListenerEvent event) async* {
    try {
      final data = event.event?.data;

      TalkerService.instance.talker.log("$data", logLevel: LogLevel.info,);

      Map<String, dynamic> json = data is String
          ? jsonDecode(data)
          : data is Map
              ? data
              : {};

      ChatModel chat = ChatModel.fromJson(json['chat']);

      debugPrint("is this chat: ${chat.videoChatRoom}");

      // debugPrint("chat room decoded data: ${jsonDecode(chat.videoChatRoom?.offer ?? '')}");

      _currentStateModel.addChat(chat);

      yield* _emitter();
    } catch (e) {
      debugPrint("_channelListenerEvent error is: $e");
    }
  }

  static Stream<ChatsStates> _changeToLoadingState(ChangeToLoadingState event) async* {
    await _currentStateModel.clearAll();
    yield LoadingChatsState(_currentStateModel);
  }

  static Stream<ChatsStates> _emitter() async* {
    if (_currentState.value is LoadingChatsState) {
      yield LoadingChatsState(_currentStateModel);
    } else if (_currentState.value is ErrorChatsState) {
      yield ErrorChatsState(_currentStateModel);
    } else if (_currentState.value is LoadedChatsState) {
      yield LoadedChatsState(_currentStateModel);
    }
  }
}
