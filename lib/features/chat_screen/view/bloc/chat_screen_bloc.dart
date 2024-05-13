import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/features/chat_screen/domain/usecases/chat_screen_chat_usecase.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/features/chat_screen/view/bloc/state_model/chat_screen_state_model.dart';
import 'package:yahay/injections/injections.dart';

import 'chat_screen_events.dart';

@immutable
class ChatScreenBloc {
  static late BehaviorSubject<ChatScreenStates> _currentState;
  static late ChatScreenStateModel _currentStateModel;
  static late ChatScreenChatUsecase _chatScreenChatUsecase;

  static Channel? _channel;

  final Sink<ChatScreenEvents> events;
  final BehaviorSubject<ChatScreenStates> _states;

  BehaviorSubject<ChatScreenStates> get states => _states;

  void dispose() {
    _channel?.cancelEventChannelStream();
    _channel = null;
    events.close();
  }

  const ChatScreenBloc._({
    required this.events,
    required BehaviorSubject<ChatScreenStates> states,
  }) : _states = states;

  factory ChatScreenBloc({
    required ChatScreenRepo chatScreenRepo,
    required ChatScreenChatRepo chatScreenChatRepo,
  }) {
    _currentStateModel = ChatScreenStateModel();
    _chatScreenChatUsecase = ChatScreenChatUsecase(chatScreenChatRepo);

    final eventsBehavior = BehaviorSubject<ChatScreenEvents>();

    final state = eventsBehavior.switchMap<ChatScreenStates>((event) async* {
      yield* _eventHandler(event);
    }).startWith(LoadingChatScreenState(_currentStateModel));

    final behaviorOfState = BehaviorSubject<ChatScreenStates>()..addStream(state);

    _currentState = behaviorOfState;

    return ChatScreenBloc._(events: eventsBehavior.sink, states: behaviorOfState);
  }

  static Stream<ChatScreenStates> _eventHandler(ChatScreenEvents event) async* {
    if (event is InitChatScreenEvent) {
      yield* _initChatScreenEvent(event);
    } else if (event is HandleChatScreenEvent) {
      yield* _handleChatScreenEvent(event);
    } else if (event is SendMessageEvent) {
      yield* _sendMessageEvent(event);
    }
    // else if (event is InitChatOnMessageEvent) {
    //   yield* _initChatOnMessageEvent(event);
    // }
  }

  // message sending event
  static Stream<ChatScreenStates> _sendMessageEvent(SendMessageEvent event) async* {
    try {
      // just check whether user subscribed to the channel
      // if (_channel == null) event.events.add(InitChatOnMessageEvent(event.events));
      //
      // send message logic
    } catch (e) {
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  // initializing chat screen on entering to the screen
  static Stream<ChatScreenStates> _initChatScreenEvent(InitChatScreenEvent event) async* {
    try {
      final chat = await _chatScreenChatUsecase.chat(chat: event.chat, withUser: event.user);

      if (chat == null || chat.uuid == null) return;

      _currentStateModel.setChat(chat);

      _channel = snoopy<PusherClientService>()
          .pusherClient
          .subscribe("${Constants.chatChannelName}${chat.uuid}");

      _channel?.bind(Constants.chatChannelEventName, (pusherEvent) {
        event.events.add(HandleChatScreenEvent(pusherEvent));
      });

      // get all chat messages here
    } catch (e) {
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  // every time when user clicks "send message" this func below will check users chat
  // if it's already exits this func do nothing
  // static Stream<ChatScreenStates> _initChatOnMessageEvent(InitChatOnMessageEvent event) async* {
  //   try {
  //     // checking channel for null one more time
  //     if (_channel != null) return;
  //     // check server for getting chat
  //     final chat = await _chatScreenChatUsecase.chat();
  //
  //     if (chat == null) return;
  //
  //     _currentStateModel.setChat(chat);
  //
  //     _channel = snoopy<PusherClientService>()
  //         .pusherClient
  //         .subscribe("${Constants.chatChannelName}${chat.uuid}");
  //
  //     _channel?.bind(Constants.chatChannelEventName, (pusherEvent) {
  //       event.events.add(HandleChatScreenEvent(pusherEvent));
  //     });
  //
  //     // get all chat messages here
  //   } catch (e) {
  //     yield ErrorChatScreenState(_currentStateModel);
  //   }
  // }

  // all handling chat messages through pusher will be here
  static Stream<ChatScreenStates> _handleChatScreenEvent(HandleChatScreenEvent event) async* {}
}
