import 'dart:async';
import 'dart:convert';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/usecases/chat_screen_chat_usecase.dart';
import 'package:yahay/src/features/chat_screen/domain/usecases/chat_screen_send_messages_usecases.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/state_model/chat_screen_state_model.dart';
import 'chat_screen_events.dart';

@immutable
class ChatScreenBloc {
  static late BehaviorSubject<ChatScreenStates> _currentState;
  static late ChatScreenStateModel _currentStateModel;
  static late ChatScreenChatUsecase _chatScreenChatUsecase;
  static late ChatScreenSendMessagesUsecases _chatScreenSendMessagesUsecases;

  final Sink<ChatScreenEvents> events;
  final BehaviorSubject<ChatScreenStates> _states;

  static late final User _currentUser;
  static late final PusherChannelsOptions _channelsOptions;

  BehaviorSubject<ChatScreenStates> get states => _states;

  void dispose() {
    _currentStateModel.disposePusherChannelWithStreamSubscription();
    _states.close();
    events.close();
  }

  const ChatScreenBloc._({
    required this.events,
    required BehaviorSubject<ChatScreenStates> states,
  }) : _states = states;

  factory ChatScreenBloc({
    required ChatScreenRepo chatScreenRepo,
    required ChatScreenChatRepo chatScreenChatRepo,
    required User user,
    required PusherChannelsOptions options,
  }) {
    _currentUser = user;
    _channelsOptions = options;
    _currentStateModel = ChatScreenStateModel();
    _chatScreenChatUsecase = ChatScreenChatUsecase(chatScreenChatRepo);
    _chatScreenSendMessagesUsecases = ChatScreenSendMessagesUsecases(chatScreenRepo);

    final eventsBehavior = BehaviorSubject<ChatScreenEvents>();

    final state = eventsBehavior.switchMap<ChatScreenStates>((event) async* {
      yield* _eventHandler(event);
    }).startWith(LoadingChatScreenState(_currentStateModel));

    final behaviorOfState = BehaviorSubject<ChatScreenStates>()..addStream(state);

    behaviorOfState.listen((value) {
      _currentState = BehaviorSubject()..add(value);
    });

    return ChatScreenBloc._(
      events: eventsBehavior.sink,
      states: behaviorOfState,
    );
  }

  static Stream<ChatScreenStates> _eventHandler(ChatScreenEvents event) async* {
    if (event is InitChatScreenEvent) {
      yield* _initChatScreenEvent(event);
    } else if (event is HandleChatMessageEvent) {
      yield* _handleChatScreenEvent(event);
    } else if (event is SendMessageEvent) {
      yield* _sendMessageEvent();
    } else if (event is ChangeEmojiPicker) {
      yield* _chaneEmojiPicker(event);
    } else if (event is RemoveAllTempCreatedChatsEvent) {
      _removeAllTempCreatedChatsEvent(event);
    }
  }

  // initializing chat screen on entering to the screen
  static Stream<ChatScreenStates> _initChatScreenEvent(InitChatScreenEvent event) async* {
    try {
      yield LoadingChatScreenState(_currentStateModel);

      _currentStateModel.setToCurrentUser(_currentUser);

      final chat = await _chatScreenChatUsecase.chat(chat: event.chat, withUser: event.user);

      // i don't know why after calling function above currentUser from "_currentStateModel.currentUser" disappears
      // i didn't find a bug
      if (_currentStateModel.currentUser == null) {
        _currentStateModel.setToCurrentUser(
          _currentUser,
        );
      }

      if (chat == null || chat.uuid == null) {
        _currentStateModel.setChat(null);
        yield ErrorChatScreenState(_currentStateModel);
        return;
      }

      _currentStateModel.setChat(chat);

      final channelName =
          "${Constants.chatChannelName}${chat.id}${Constants.chatChannelUUID}${chat.uuid}";

      debugPrint("channel name: $channelName");

      _currentStateModel.setPusherChannel(
        PusherChannelsClient.websocket(
          options: _channelsOptions,
          connectionErrorHandler: (f, s, t) {},
        ),
      );

      final channel = _currentStateModel.pusherChannelClient?.publicChannel(channelName);

      final subs = _currentStateModel.pusherChannelClient?.onConnectionEstablished.listen(
        (e) {
          channel?.subscribeIfNotUnsubscribed();
        },
      );

      _currentStateModel.setToSubscription(subs);

      await _currentStateModel.pusherChannelClient?.connect();

      channel?.bind(Constants.chatChannelEventName).listen((pusherEvent) {
        event.events.add(HandleChatMessageEvent(pusherEvent));
      });

      yield LoadedChatScreenState(_currentStateModel);

      // get all chat messages here
    } catch (e) {
      debugPrint("channel connecting error: $e");
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  // message sending event
  static Stream<ChatScreenStates> _sendMessageEvent() async* {
    try {
      if (_currentStateModel.messageController.text.trim().isEmpty &&
          _currentStateModel.pickedFile == null) {
        return;
      }

      final chatMessage = ChatMessageModel(
        chat: ChatModel.fromEntity(_currentStateModel.currentChat),
        user: UserModel.fromEntity(_currentStateModel.currentUser),
        relatedToUser: UserModel.fromEntity(_currentStateModel.relatedUser),
        message: _currentStateModel.messageController.text.trim(),
        chatMessageUUID: const Uuid().v4(),
        file: _currentStateModel.pickedFile,
        createdAt: DateTime.now().toString().substring(0, 19),
        messageSent: false,
      );

      _currentStateModel.addMessage(chatMessage);

      _currentStateModel.clearMessage();

      yield* _emitter();

      await _chatScreenSendMessagesUsecases.sendMessage(
        chatMessage: chatMessage,
      );
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

  static Stream<ChatScreenStates> _handleChatScreenEvent(HandleChatMessageEvent event) async* {
    debugPrint("coming data: ${event.event?.data}");
    try {
      Map<String, dynamic> messageJson = jsonDecode(event.event?.data ?? '');

      if (messageJson.containsKey('message') && messageJson['message'] != null) {
        ChatMessageModel message =
            ChatMessageModel.fromJson(messageJson['message']).copyWith(messageSent: true);
        _currentStateModel.addMessage(message);
      }

      // find problem here
      if (messageJson.containsKey('chat') && messageJson['chat'] != null) {
        debugPrint("chat has chat room: ${_currentStateModel.currentChat?.videoChatRoom}");
        ChatModel chat = ChatModel.fromJson(messageJson['chat']);
        final currentChatFromModel = ChatModel.fromEntity(_currentStateModel.currentChat);
        _currentStateModel.setChat(
          currentChatFromModel?.copyWith(
            videoChatRoom: chat.videoChatRoom,
            videoChatStreaming: chat.videoChatStreaming,
          ),
          setChatMessages: false,
        );
        debugPrint("chat has chat room 2: ${_currentStateModel.currentChat?.videoChatRoom}");
      }

      yield* _emitter();
    } catch (e) {
      yield ErrorChatScreenState(_currentStateModel);
    }
  }

  static Stream<ChatScreenStates> _chaneEmojiPicker(
    ChangeEmojiPicker event,
  ) async* {
    try {
      _currentStateModel.changeEmojiPicker(value: event.value);
      yield* _emitter();
    } catch (e) {
      debugPrint("_chaneEmojiPicker error is: $e");
    }
  }

  static Stream<ChatScreenStates> _emitter() async* {
    if (_currentState.value is LoadingChatScreenState) {
      yield LoadingChatScreenState(_currentStateModel);
    } else if (_currentState.value is ErrorChatScreenState) {
      yield ErrorChatScreenState(_currentStateModel);
    } else if (_currentState.value is LoadedChatScreenState) {
      yield LoadedChatScreenState(_currentStateModel);
    } else {
      yield LoadedChatScreenState(_currentStateModel); // Default to loaded state
    }
  }
}
