import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/features/chat_screen/domain/usecases/chat_screen_chat_usecase.dart';
import 'package:yahay/features/chat_screen/domain/usecases/chat_screen_send_messages_usecases.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/features/chat_screen/view/bloc/state_model/chat_screen_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'chat_screen_events.dart';

@immutable
class ChatScreenBloc {
  static late BehaviorSubject<ChatScreenStates> _currentState;
  static late ChatScreenStateModel _currentStateModel;
  static late ChatScreenChatUsecase _chatScreenChatUsecase;
  static late ChatScreenSendMessagesUsecases _chatScreenSendMessagesUsecases;

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
    _chatScreenSendMessagesUsecases = ChatScreenSendMessagesUsecases(chatScreenRepo);

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
    } else if (event is RemoveAllTempCreatedChatsEvent) {
      _removeAllTempCreatedChatsEvent(event);
    }
  }

  // message sending event
  static Stream<ChatScreenStates> _sendMessageEvent(SendMessageEvent event) async* {
    try {
      if (_currentStateModel.messageController.text.trim().isEmpty) return;

      if (_currentStateModel.pickedFile == null) {
        _chatScreenSendMessagesUsecases.sendMessage(
          chat: _currentStateModel.currentChat,
          toUser: _currentStateModel.relatedUser,
        );
      } else {}
    } catch (e) {
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  // initializing chat screen on entering to the screen
  static Stream<ChatScreenStates> _initChatScreenEvent(InitChatScreenEvent event) async* {
    try {
      yield LoadingChatScreenState(_currentStateModel);

      final chat = await _chatScreenChatUsecase.chat(chat: event.chat, withUser: event.user);

      if (chat == null || chat.uuid == null) {
        _currentStateModel.setChat(null);
        yield ErrorChatScreenState(_currentStateModel);
        return;
      }

      _currentStateModel.setChat(chat);

      _channel = snoopy<PusherClientService>()
          .pusherClient
          .subscribe("${Constants.chatChannelName}${chat.uuid}");

      _channel?.bind(Constants.chatChannelEventName, (pusherEvent) {
        event.events.add(HandleChatScreenEvent(pusherEvent));
      });

      yield LoadedChatScreenState(_currentStateModel);

      // get all chat messages here
    } catch (e) {
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  static void _removeAllTempCreatedChatsEvent(RemoveAllTempCreatedChatsEvent event) {
    try {
      _chatScreenChatUsecase.removeAllTempCreatedChats(chat: _currentStateModel.currentChat);
    } catch (e) {
      debugPrint("_removeAllTempCreatedChatsEvent error is: $e");
    }
  }

  static Stream<ChatScreenStates> _handleChatScreenEvent(HandleChatScreenEvent event) async* {}
}
