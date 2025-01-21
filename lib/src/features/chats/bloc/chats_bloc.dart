import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
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
//     try {
//       final channelName = "${Constants.channelNotifyOfUserName}${_currentUser?.id}";
//
//       debugPrint("current whole channel listeners: $channelName");
//
//       _currentStateModel.setToPusherClient(
//         PusherChannelsClient.websocket(
//           options: _pusherChannelsOptions,
//           connectionErrorHandler: (f, s, t) {},
//         ),
//       );
//
//       final chatChannel = _currentStateModel.pusherClientService?.publicChannel(channelName);
//
//       final subs = _currentStateModel.pusherClientService?.onConnectionEstablished.listen((e) {
//         chatChannel?.subscribeIfNotUnsubscribed();
//       });
//
//       _currentStateModel.setToSubscription(subs);
//
//       await _currentStateModel.pusherClientService?.connect();
//
//       chatChannel?.bind(Constants.channelNotifyOfUserEventName).listen((pusherData) {
//         event.events.add(ChatListenerEvent(pusherData));
//       });
//     } catch (e) {
//       debugPrint("current whole channel listeners error is: $e");
//     }
//   }
//
//   static Stream<ChatsStates> _getUserChatsEvent(GetUserChatsEvent event) async* {
//     try {
//       if (_currentState.value is LoadedChatsState && !event.refresh) return;
//
//       yield LoadingChatsState(_currentStateModel);
//
//       _currentStateModel.setChat(await _getUserChatsUseCase.chats());
//
//       debugPrint("chat length is: ${_currentStateModel.chats.length}");
//
//       yield LoadedChatsState(_currentStateModel);
//     } catch (e) {
//       debugPrint("_getUserChatsEvent error is: $e");
//       yield ErrorChatsState(_currentStateModel);
//     }
//   }
//
//   static Stream<ChatsStates> _chatListenerEvent(ChatListenerEvent event) async* {
//     try {
//       final data = event.event?.data;
//
//       _logger.log(
//         Level.debug,
//         "$data",
//       );
//
//       Map<String, dynamic> json = data is String
//           ? jsonDecode(data)
//           : data is Map
//               ? data
//               : {};
//
//       ChatModel chat = ChatModel.fromJson(json['chat']);
//
//       debugPrint("is this chat: ${chat.videoChatRoom}");
//
//       // debugPrint("chat room decoded data: ${jsonDecode(chat.videoChatRoom?.offer ?? '')}");
//
//       _currentStateModel.addChat(chat, _currentUser);
//
//       yield* _emitter();
//     } catch (e) {
//       debugPrint("_channelListenerEvent error is: $e");
//     }
//   }
//
//   static Stream<ChatsStates> _changeToLoadingState(ChangeToLoadingState event) async* {
//     await _currentStateModel.clearAll();
//     yield LoadingChatsState(_currentStateModel);
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

  const factory ChatsEvents.chatListenerEvent(final ChannelReadEvent? event) = _ChatListenerEvent;

  const factory ChatsEvents.changeToLoadingState() = _ChangeToLoadingState;
}

@immutable
@freezed
class ChatsStates with _$ChatsStates {
  const factory ChatsStates.initial(final ChatsStateModel chatsStateModel) = _InitialChatsState;

  const factory ChatsStates.loadingChatsState(final ChatsStateModel chatsStateModel) =
      _LoadingChatsState;

  const factory ChatsStates.errorChatsState(final ChatsStateModel chatsStateModel) =
      _ErrorChatsState;

  const factory ChatsStates.loadedChatsState(final ChatsStateModel chatsStateModel) =
      _LoadedChatsState;
}

class ChatsBloc extends Bloc<ChatsEvents, ChatsStates> {
  //
  PusherChannelsClient? _pusherClientService;

  StreamSubscription<void>? _channelSubscription;

  //
  final ChatsRepo _chatsRepo;
  final User? _currentUser;
  final PusherChannelsOptions _pusherChannelsOptions;
  final Logger _logger;

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
    //
    on<ChatsEvents>(
      (event, emit) => event.map(
        getUserChatsEvent: (event) => _getUserChatsEvent(event, emit),
        chatListenerEvent: (event) => _chatListenerEvent(event, emit),
        changeToLoadingState: (event) => _changeToLoadingState(event, emit),
      ),
    );
  }

  void _getUserChatsEvent(
    _GetUserChatsEvent event,
    Emitter<ChatsStates> emit,
  ) async {}

  void _chatListenerEvent(
    _ChatListenerEvent event,
    Emitter<ChatsStates> emit,
  ) async {}

  void _changeToLoadingState(
    _ChangeToLoadingState event,
    Emitter<ChatsStates> emit,
  ) async {}

  @override
  Future<void> close() async {
    await _pusherClientService?.disconnect();
    _pusherClientService?.dispose();
    await _channelSubscription?.cancel();
    return await super.close();
  }
}
