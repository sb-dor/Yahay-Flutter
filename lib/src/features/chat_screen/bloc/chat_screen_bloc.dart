import 'dart:async';
import 'dart:convert';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';

import 'state_model/chat_screen_state_model.dart';

part 'chat_screen_bloc.freezed.dart';

// @immutable
// class ChatScreenBloc {
//   static late BehaviorSubject<ChatScreenStates> _currentState;
//   static late ChatScreenStateModel _currentStateModel;
//   static late ChatScreenChatUsecase _chatScreenChatUsecase;
//   static late ChatScreenSendMessagesUsecases _chatScreenSendMessagesUsecases;
//
//   final Sink<ChatScreenEvents> events;
//   final BehaviorSubject<ChatScreenStates> _states;
//
//   static late final User? _currentUser;
//   static late final PusherChannelsOptions _channelsOptions;
//
//   BehaviorSubject<ChatScreenStates> get states => _states;
//
//   void dispose() async {
//     await _currentStateModel.disposePusherChannelWithStreamSubscription();
//     await _states.drain();
//     _states.close();
//     events.close();
//   }
//
//   const ChatScreenBloc._({
//     required this.events,
//     required BehaviorSubject<ChatScreenStates> states,
//   }) : _states = states;
//
//   factory ChatScreenBloc({
//     required ChatScreenRepo chatScreenRepo,
//     required ChatScreenChatRepo chatScreenChatRepo,
//     required User? user,
//     required PusherChannelsOptions options,
//   }) {
//     _currentUser = user;
//     _channelsOptions = options;
//     _currentStateModel = ChatScreenStateModel();
//     _chatScreenChatUsecase = ChatScreenChatUsecase(chatScreenChatRepo);
//     _chatScreenSendMessagesUsecases = ChatScreenSendMessagesUsecases(chatScreenRepo);
//
//     final eventsBehavior = BehaviorSubject<ChatScreenEvents>();
//
//     final state = eventsBehavior.switchMap<ChatScreenStates>((event) async* {
//       yield* _eventHandler(event);
//     }).startWith(LoadingChatScreenState(_currentStateModel));
//
//     final behaviorOfState = BehaviorSubject<ChatScreenStates>()..addStream(state);
//
//     behaviorOfState.listen((value) {
//       _currentState = BehaviorSubject()..add(value);
//     });
//
//     return ChatScreenBloc._(
//       events: eventsBehavior.sink,
//       states: behaviorOfState,
//     );
//   }
//
//   static Stream<ChatScreenStates> _eventHandler(ChatScreenEvents event) async* {
//     if (event is InitChatScreenEvent) {
//       yield* _initChatScreenEvent(event);
//     } else if (event is HandleChatMessageEvent) {
//       yield* _handleChatScreenEvent(event);
//     } else if (event is SendMessageEvent) {
//       yield* _sendMessageEvent();
//     } else if (event is ChangeEmojiPicker) {
//       yield* _chaneEmojiPicker(event);
//     } else if (event is RemoveAllTempCreatedChatsEvent) {
//       _removeAllTempCreatedChatsEvent(event);
//     }
//   }
//
//   // initializing chat screen on entering to the screen
//   static Stream<ChatScreenStates> _initChatScreenEvent(InitChatScreenEvent event) async* {
//     try {
//       yield LoadingChatScreenState(_currentStateModel);
//
//       _currentStateModel.setToCurrentUser(_currentUser);
//
//       final chat = await _chatScreenChatUsecase.chat(chat: event.chat, withUser: event.user);
//
//       // i don't know why after calling function above currentUser from "_currentStateModel.currentUser" disappears
//       // i didn't find a bug
//       if (_currentStateModel.currentUser == null) {
//         _currentStateModel.setToCurrentUser(
//           _currentUser,
//         );
//       }
//
//       if (chat == null || chat.uuid == null) {
//         _currentStateModel.setChat(null);
//         yield ErrorChatScreenState(_currentStateModel);
//         return;
//       }
//
//       _currentStateModel.setChat(chat);
//
//       final channelName =
//           "${Constants.chatChannelName}${chat.id}${Constants.chatChannelUUID}${chat.uuid}";
//
//       debugPrint("channel name: $channelName");
//
//       _currentStateModel.setPusherChannel(
//         PusherChannelsClient.websocket(
//           options: _channelsOptions,
//           connectionErrorHandler: (f, s, t) {},
//         ),
//       );
//
//       final channel = _currentStateModel.pusherChannelClient?.publicChannel(channelName);
//
//       final subs = _currentStateModel.pusherChannelClient?.onConnectionEstablished.listen(
//         (e) {
//           channel?.subscribeIfNotUnsubscribed();
//         },
//       );
//
//       _currentStateModel.setToSubscription(subs);
//
//       await _currentStateModel.pusherChannelClient?.connect();
//
//       channel?.bind(Constants.chatChannelEventName).listen((pusherEvent) {
//         event.events.add(HandleChatMessageEvent(pusherEvent));
//       });
//
//       yield LoadedChatScreenState(_currentStateModel);
//
//       // get all chat messages here
//     } catch (e) {
//       debugPrint("channel connecting error: $e");
//       yield ErrorChatScreenState(_currentStateModel);
//     }
//   }
//
//   // message sending event
//   static Stream<ChatScreenStates> _sendMessageEvent() async* {
//     try {
//       if (_currentStateModel.messageController.text.trim().isEmpty &&
//           _currentStateModel.pickedFile == null) {
//         return;
//       }
//
//       final chatMessage = ChatMessageModel(
//         chat: ChatModel.fromEntity(_currentStateModel.currentChat),
//         user: UserModel.fromEntity(_currentStateModel.currentUser),
//         relatedToUser: UserModel.fromEntity(_currentStateModel.relatedUser),
//         message: _currentStateModel.messageController.text.trim(),
//         chatMessageUUID: const Uuid().v4(),
//         file: _currentStateModel.pickedFile,
//         createdAt: DateTime.now().toString().substring(0, 19),
//         messageSent: false,
//       );
//
//       _currentStateModel.addMessage(chatMessage);
//
//       _currentStateModel.clearMessage();
//
//       yield* _emitter();
//
//       await _chatScreenSendMessagesUsecases.sendMessage(
//         chatMessage: chatMessage,
//       );
//     } catch (e) {
//       yield ErrorChatScreenState(_currentStateModel);
//     }
//   }
//
//   static void _removeAllTempCreatedChatsEvent(RemoveAllTempCreatedChatsEvent event) {
//     try {
//       _chatScreenChatUsecase.removeAllTempCreatedChats(chat: _currentStateModel.currentChat);
//     } catch (e) {
//       debugPrint("_removeAllTempCreatedChatsEvent error is: $e");
//     }
//   }
//
//   static Stream<ChatScreenStates> _handleChatScreenEvent(HandleChatMessageEvent event) async* {
//     debugPrint("coming data: ${event.event?.data}");
//     try {
//       Map<String, dynamic> messageJson = jsonDecode(event.event?.data ?? '');
//
//       if (messageJson.containsKey('message') && messageJson['message'] != null) {
//         ChatMessageModel message =
//             ChatMessageModel.fromJson(messageJson['message']).copyWith(messageSent: true);
//         _currentStateModel.addMessage(message);
//       }
//
//       // find problem here
//       if (messageJson.containsKey('chat') && messageJson['chat'] != null) {
//         debugPrint("chat has chat room: ${_currentStateModel.currentChat?.videoChatRoom}");
//         ChatModel chat = ChatModel.fromJson(messageJson['chat']);
//         final currentChatFromModel = ChatModel.fromEntity(_currentStateModel.currentChat);
//         _currentStateModel.setChat(
//           currentChatFromModel?.copyWith(
//             videoChatRoom: chat.videoChatRoom,
//             videoChatStreaming: chat.videoChatStreaming,
//           ),
//           setChatMessages: false,
//         );
//         debugPrint("chat has chat room 2: ${_currentStateModel.currentChat?.videoChatRoom}");
//       }
//
//       yield* _emitter();
//     } catch (e) {
//       yield ErrorChatScreenState(_currentStateModel);
//     }
//   }
//
//   static Stream<ChatScreenStates> _chaneEmojiPicker(
//     ChangeEmojiPicker event,
//   ) async* {
//     try {
//       _currentStateModel.changeEmojiPicker(value: event.value);
//       yield* _emitter();
//     } catch (e) {
//       debugPrint("_chaneEmojiPicker error is: $e");
//     }
//   }
//
//   static Stream<ChatScreenStates> _emitter() async* {
//     if (_currentState.value is LoadingChatScreenState) {
//       yield LoadingChatScreenState(_currentStateModel);
//     } else if (_currentState.value is ErrorChatScreenState) {
//       yield ErrorChatScreenState(_currentStateModel);
//     } else if (_currentState.value is LoadedChatScreenState) {
//       yield LoadedChatScreenState(_currentStateModel);
//     } else {
//       yield LoadedChatScreenState(_currentStateModel); // Default to loaded state
//     }
//   }
// }

@immutable
@freezed
abstract class ChatScreenEvents with _$ChatScreenEvents {
  // init chat on entering to the screen (if chat was already created)
  const factory ChatScreenEvents.initChatScreenEvent({
    final Chat? chat,
    final User? user, // temp for creating temp chat if chat does not exist
  }) = _InitChatScreenEvent;

  const factory ChatScreenEvents.removeAllTempCreatedChatsEvent() = _RemoveAllTempCreatedChatsEvent;

  const factory ChatScreenEvents.handleChatMessageEvent() = _HandleChatMessageEvent;

  const factory ChatScreenEvents.sendMessageEvent() = _SendMessageEvent;

  const factory ChatScreenEvents.changeEmojiPicker() = _ChangeEmojiPicker;
}

@immutable
@freezed
sealed class ChatScreenStates with _$ChatScreenStates {
  const factory ChatScreenStates.loading(final ChatScreenStateModel chatScreenStateModel) =
      LoadingChatScreenState;

  const factory ChatScreenStates.error(final ChatScreenStateModel chatScreenStateModel) =
      ErrorChatScreenState;

  const factory ChatScreenStates.loaded(final ChatScreenStateModel chatScreenStateModel) =
      LoadedChatScreenState;
}

class ChatScreenBloc extends Bloc<ChatScreenEvents, ChatScreenStates> {
  final ChatScreenRepo _iChatScreenRepo;
  final ChatScreenChatRepo _iChatScreenChatRepo;
  final User? _currentUser;
  final PusherChannelsOptions _options;

  ChatScreenBloc({
    required ChatScreenRepo chatScreenRepo,
    required ChatScreenChatRepo chatScreenChatRepo,
    required User? currentUser,
    required PusherChannelsOptions options,
    required ChatScreenStates initialState,
  })  : _iChatScreenRepo = chatScreenRepo,
        _iChatScreenChatRepo = chatScreenChatRepo,
        _currentUser = currentUser,
        _options = options,
        super(initialState) {
    //
    on<ChatScreenEvents>(
      (event, emit) => event.map(
        initChatScreenEvent: (event) => _initChatScreenEvent(event, emit),
        removeAllTempCreatedChatsEvent: removeAllTempCreatedChatsEvent,
        handleChatMessageEvent: handleChatMessageEvent,
        sendMessageEvent: sendMessageEvent,
        changeEmojiPicker: changeEmojiPicker,
      ),
    );
    //
  }

  void _initChatScreenEvent(
    _InitChatScreenEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();

    try {
      emit(ChatScreenStates.loading(currentStateModel));

      currentStateModel = currentStateModel.copyWith(currentUser: _currentUser);

      final chat = await _iChatScreenChatRepo.chat(chat: event.chat, withUser: event.user);

      // i don't know why after calling function above currentUser from "_currentStateModel.currentUser" disappears
      // i didn't find a bug
      // if (_currentStateModel.currentUser == null) {
      //   _currentStateModel.setToCurrentUser(
      //     _currentUser,
      //   );
      // }

      if (chat == null || chat.uuid == null) {
        setChat(currentStateModel: currentStateModel, chat: null);
        emit(ChatScreenStates.error(currentStateModel));
        return;
      }

      setChat(currentStateModel: currentStateModel, chat: chat);

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

  // logic
  void setChat({
    required ChatScreenStateModel currentStateModel,
    Chat? chat,
    bool setChatMessages = true,
  }) {
    if (chat == null) return;
    currentStateModel = currentStateModel.copyWith(
      currentChat: chat,
    );
    if (setChatMessages) {
      List<ChatMessage> chatMessages = List.from(currentStateModel.messages);
      chatMessages.addAll((chat.messages ?? []).reversed.toList());
      currentStateModel = currentStateModel.copyWith(
        messages: chatMessages,
      );
    }
  }
//
// void setToFile(File? file) => _pickedFile = file;
//
// void setToRelatedUser(User? user) => _relatedUser = user;
//
// void setToCurrentUser(User? user) => _currentUser = user;
//
// void addMessage(ChatMessage message) {
//   final findMessage =
//       _messages.firstWhereOrNull((e) => e.chatMessageUUID == message.chatMessageUUID);
//   if (findMessage != null) {
//     _messages[_messages.indexWhere((e) => e.chatMessageUUID == message.chatMessageUUID)] =
//         ChatMessageModel.fromEntity(findMessage)!.copyWith(messageSent: true);
//   } else {
//     _messages.add(message);
//   }
// }
//
// void clearMessage() => _messageController.clear();
//
// void changeEmojiPicker({bool? value}) {
//   if (value != null) {
//     _showEmojiPicker = value;
//     return;
//   }
//   _showEmojiPicker = !_showEmojiPicker;
// }
//
// void setPusherChannel(PusherChannelsClient client) {
//   _pusherChannelsClient = client;
// }
//
// void setToSubscription(StreamSubscription<void>? subs) {
//   _channelSubscription = subs;
// }
//
// Future<void> disposePusherChannelWithStreamSubscription() async {
//   await _pusherChannelsClient?.disconnect();
//   await _channelSubscription?.cancel();
//   _pusherChannelsClient?.dispose();
//   _channelSubscription = null;
//   _pusherChannelsClient = null;
// }
}
