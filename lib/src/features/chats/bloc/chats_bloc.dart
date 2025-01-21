import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';
import 'state_model/chats_state_model.dart';

part 'chats_bloc.freezed.dart';

// typedef PusherDataListener = void Function(
//     String eventName, void Function(PusherEvent? event) onEvent);

// @immutable
// class ChatsBloc {
//   static late BehaviorSubject<ChatsStates> _currentState; // is necessary if you use _emitter()
//   static late ChatsStateModel _currentStateModel;
//   static late GetUserChatsUseCase _getUserChatsUseCase;
//
//   final Sink<ChatsEvents> events;
//   final BehaviorSubject<ChatsStates> _states;
//
//   BehaviorSubject<ChatsStates> get states => _states;
//
//   static late final User? _currentUser;
//   static late final PusherChannelsOptions _pusherChannelsOptions;
//   static late final Logger _logger;
//
//   const ChatsBloc._({
//     required this.events,
//     required final BehaviorSubject<ChatsStates> states,
//   }) : _states = states;
//
//   factory ChatsBloc({
//     required ChatsRepo chatsRepo,
//     required final User? currentUser,
//     required final PusherChannelsOptions pusherChannelsOptions,
//     required final Logger logger,
//   }) {
//     _currentUser = currentUser;
//     _pusherChannelsOptions = pusherChannelsOptions;
//     _logger = logger;
//     _currentStateModel = ChatsStateModel();
//     _getUserChatsUseCase = GetUserChatsUseCase(chatsRepo);
//
//     final chatsEventsBehavior = BehaviorSubject<ChatsEvents>();
//
//     final chatsEventsStates = chatsEventsBehavior.flatMap<ChatsStates>((event) async* {
//       if (event is ChatListenerEvent) {
//         yield* _chatListenerEvent(event);
//       } else if (event is ChatListenerInitEvent) {
//         yield* _chatListenerInitEvent(event);
//       } else if (event is GetUserChatsEvent) {
//         yield* _getUserChatsEvent(event);
//       } else if (event is ChangeToLoadingState) {
//         yield* _changeToLoadingState(event);
//       }
//     }).startWith(LoadingChatsState(_currentStateModel));
//
//     final BehaviorSubject<ChatsStates> behaviorOfStates = BehaviorSubject<ChatsStates>()
//       ..addStream(chatsEventsStates);
//
//     _currentState = behaviorOfStates;
//
//     return ChatsBloc._(
//       events: chatsEventsBehavior.sink,
//       states: behaviorOfStates,
//     );
//   }
//
//   // for channel listening (for getting new chats when whoever writes)
//   static Stream<ChatsStates> _chatListenerInitEvent(ChatListenerInitEvent event) async* {

//   }
//
//   static Stream<ChatsStates> _getUserChatsEvent(GetUserChatsEvent event) async* {

//   }
//
//   static Stream<ChatsStates> _chatListenerEvent(ChatListenerEvent event) async* {

//   }
//
//   static Stream<ChatsStates> _changeToLoadingState(ChangeToLoadingState event) async* {

//   }
//
//   static Stream<ChatsStates> _emitter() async* {
//     if (_currentState.value is LoadingChatsState) {
//       yield LoadingChatsState(_currentStateModel);
//     } else if (_currentState.value is ErrorChatsState) {
//       yield ErrorChatsState(_currentStateModel);
//     } else if (_currentState.value is LoadedChatsState) {
//       yield LoadedChatsState(_currentStateModel);
//     }
//   }
// }

@immutable
@freezed
class ChatsEvents with _$ChatsEvents {
  const factory ChatsEvents.getUserChatsEvent({@Default(false) bool refresh}) = _GetUserChatsEvent;

  const factory ChatsEvents.chatListenerInitialEvent() = _ChatListenerInitialEvent;

  const factory ChatsEvents.chatListenerEvent(final ChannelReadEvent? event) = _ChatListenerEvent;

  const factory ChatsEvents.changeToLoadingState() = _ChangeToLoadingState;
}

@immutable
@freezed
sealed class ChatsStates with _$ChatsStates {
  const factory ChatsStates.initial(final ChatsStateModel chatsStateModel) = InitialChatsState;

  const factory ChatsStates.loadingChatsState(final ChatsStateModel chatsStateModel) =
      LoadingChatsState;

  const factory ChatsStates.errorChatsState(final ChatsStateModel chatsStateModel) =
      ErrorChatsState;

  const factory ChatsStates.loadedChatsState(final ChatsStateModel chatsStateModel) =
      LoadedChatsState;
}

class ChatsBloc extends Bloc<ChatsEvents, ChatsStates> {
  //
  PusherChannelsClient? _pusherClientService;
  StreamSubscription<void>? _channelSubscription;
  StreamSubscription<void>? _channelSubscriptionInformation;

  //
  final ChatsRepo _chatsRepo;
  final User? _currentUser;
  final PusherChannelsOptions _pusherChannelsOptions;
  final Logger _logger;
  late final ChatsStateModel _currentStateModel;

  ChatsBloc({
    required final ChatsRepo chatsRepo,
    required final User? currentUser,
    required final PusherChannelsOptions pusherChannelsOptions,
    required final Logger logger,
    required ChatsStates initialState,
  })  : _chatsRepo = chatsRepo,
        _currentUser = currentUser,
        _pusherChannelsOptions = pusherChannelsOptions,
        _logger = logger,
        super(initialState) {
    _currentStateModel = initialState.chatsStateModel;
    //
    on<ChatsEvents>(
      (event, emit) => event.map(
        getUserChatsEvent: (event) => _getUserChatsEvent(event, emit),
        chatListenerInitialEvent: (event) => _chatListenerInitialEvent(event, emit),
        chatListenerEvent: (event) => _chatListenerEvent(event, emit),
        changeToLoadingState: (event) => _changeToLoadingState(event, emit),
      ),
    );
  }

  void _getUserChatsEvent(
    _GetUserChatsEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      if (state is LoadedChatsState && !event.refresh) return;

      emit(ChatsStates.loadingChatsState(_currentStateModel));

      _currentStateModel.setChat(await _chatsRepo.chats());

      _logger.log(Level.debug, "chat length is: ${_currentStateModel.chats.length}");

      emit(ChatsStates.loadedChatsState(_currentStateModel));
    } catch (e) {
      _logger.log(Level.error, "_getUserChatsEvent error is: $e");
      emit(ChatsStates.errorChatsState(_currentStateModel));
    }
  }

  void _chatListenerInitialEvent(
    _ChatListenerInitialEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      final channelName = "${Constants.channelNotifyOfUserName}${_currentUser?.id}";

      _logger.log(Level.debug, "current whole channel listeners: $channelName");

      _pusherClientService = PusherChannelsClient.websocket(
        options: _pusherChannelsOptions,
        connectionErrorHandler: (f, s, t) {},
      );

      final chatChannel = _pusherClientService?.publicChannel(channelName);

      _channelSubscriptionInformation = _pusherClientService?.onConnectionEstablished.listen((e) {
        chatChannel?.subscribeIfNotUnsubscribed();
      });

      await _pusherClientService?.connect();

      _channelSubscription = chatChannel?.bind(Constants.channelNotifyOfUserEventName).listen(
        (pusherData) {
          add(ChatsEvents.chatListenerEvent(pusherData));
        },
      );
    } catch (e) {
      _logger.log(Level.debug, "current whole channel listeners error is: $e");
    }
  }

  void _chatListenerEvent(
    _ChatListenerEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      final data = event.event?.data;

      _logger.log(
        Level.debug,
        "$data",
      );

      Map<String, dynamic> json = data is String
          ? jsonDecode(data)
          : data is Map
              ? data
              : {};

      ChatModel chat = ChatModel.fromJson(json['chat']);

      _logger.log(Level.debug, "is this chat: ${chat.videoChatRoom}");

      // debugPrint("chat room decoded data: ${jsonDecode(chat.videoChatRoom?.offer ?? '')}");

      _currentStateModel.addChat(chat, _currentUser);

      _emitter(emit);
    } catch (e) {
      _logger.log(Level.error, "_channelListenerEvent error is: $e");
    }
  }

  void _changeToLoadingState(
    _ChangeToLoadingState event,
    Emitter<ChatsStates> emit,
  ) async {
    _currentStateModel.chats.clear();
    _emitter(emit);
  }

  void _emitter(Emitter<ChatsStates> emit) {
    switch (state) {
      case InitialChatsState():
        emit(ChatsStates.initial(_currentStateModel));
        break;
      case LoadingChatsState():
        emit(ChatsStates.loadingChatsState(_currentStateModel));
        break;
      case ErrorChatsState():
        emit(ChatsStates.errorChatsState(_currentStateModel));
        break;
      case LoadedChatsState():
        emit(ChatsStates.loadedChatsState(_currentStateModel));
    }
  }

  @override
  Future<void> close() async {
    await _pusherClientService?.disconnect();
    _pusherClientService?.dispose();
    await _channelSubscription?.cancel();
    await _channelSubscriptionInformation?.cancel();
    return await super.close();
  }
}
