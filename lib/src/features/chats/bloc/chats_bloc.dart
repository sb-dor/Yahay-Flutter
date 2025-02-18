import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';
import 'state_model/chats_state_model.dart';
import 'stream_transformers/chats_stream_transformers.dart';

part 'chats_bloc.freezed.dart';

@immutable
@freezed
sealed class ChatsEvents with _$ChatsEvents {
  const factory ChatsEvents.getUserChatsEvent({@Default(false) bool refresh}) = _Chats$GetUserEvent;

  const factory ChatsEvents.chatListenerInitialEvent() = _Chats$ListenerInitialEvent;

  const factory ChatsEvents.chatListenerEvent(final ChatModel? chatModel) = _Chat$ListenerEvent;

  const factory ChatsEvents.changeToLoadingState() = _Chats$ChangeToLoadingStateEvent;
}

@immutable
@freezed
sealed class ChatsStates with _$ChatsStates {
  const factory ChatsStates.initial(final ChatsStateModel chatsStateModel) = Chats$InitialState;

  const factory ChatsStates.inProgress(final ChatsStateModel chatsStateModel) =
      Chats$InProgressState;

  const factory ChatsStates.error(final ChatsStateModel chatsStateModel) = Chats$ErrorState;

  const factory ChatsStates.successful(final ChatsStateModel chatsStateModel) =
      Chats$SuccessfulState;
}

class ChatsBloc extends Bloc<ChatsEvents, ChatsStates> {
  //
  PusherChannelsClient? _pusherClientService;
  StreamSubscription<void>? _channelSubscription;
  StreamSubscription<void>? _channelSubscriptionInformation;

  //
  final ChatsRepo _chatsRepo;
  final UserModel? _currentUser;
  final PusherChannelsOptions _pusherChannelsOptions;
  final Logger _logger;

  ChatsBloc({
    required final ChatsRepo chatsRepo,
    required final UserModel? currentUser,
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
        chatListenerInitialEvent: (event) => _chatListenerInitialEvent(event, emit),
        chatListenerEvent: (event) => _chatListenerEvent(event, emit),
        changeToLoadingState: (event) => _changeToLoadingState(event, emit),
      ),
    );
  }

  void _getUserChatsEvent(
    _Chats$GetUserEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      if (state is Chats$SuccessfulState && !event.refresh) return;

      emit(ChatsStates.inProgress(state.chatsStateModel));

      final currentStateModel = state.chatsStateModel.copyWith(
        chats: await _chatsRepo.chats(),
      );

      _logger.log(Level.debug, "chat length is: ${currentStateModel.chats.length}");

      emit(ChatsStates.successful(currentStateModel));
    } catch (e) {
      _logger.log(Level.error, "_getUserChatsEvent error is: $e");
      emit(ChatsStates.error(state.chatsStateModel));
    }
  }

  void _chatListenerInitialEvent(
    _Chats$ListenerInitialEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      if (_channelSubscription != null) return;

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

      _channelSubscription = chatChannel
          ?.bind(Constants.channelNotifyOfUserEventName)
          .transform(ChatsStreamTransformers(logger: _logger))
          .listen(
        (chatModel) {
          add(ChatsEvents.chatListenerEvent(chatModel));
        },
      );
    } catch (e) {
      _logger.log(Level.debug, "current whole channel listeners error is: $e");
    }
  }

  void _chatListenerEvent(
    _Chat$ListenerEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    try {
      _logger.log(
        Level.debug,
        "${event.chatModel}",
      );

      // debugPrint("chat room decoded data: ${jsonDecode(chat.videoChatRoom?.offer ?? '')}");

      if (event.chatModel != null) {
        final currentStateModel = state.chatsStateModel.copyWith(
          chats: _addChat(
            chat: event.chatModel,
            currentChats: state.chatsStateModel.chats,
          ),
        );

        _emitter(currentStateModel: currentStateModel, emit: emit);
      }
    } catch (e) {
      _logger.log(Level.error, "_channelListenerEvent error is: $e");
    }
  }

  void _changeToLoadingState(
    _Chats$ChangeToLoadingStateEvent event,
    Emitter<ChatsStates> emit,
  ) async {
    final currentState = state.chatsStateModel.copyWith(chats: <ChatModel>[]);
    _emitter(currentStateModel: currentState, emit: emit);
  }

  void _emitter({
    required ChatsStateModel currentStateModel,
    required Emitter<ChatsStates> emit,
  }) {
    switch (state) {
      case Chats$InitialState():
        emit(ChatsStates.initial(currentStateModel));
        break;
      case Chats$InProgressState():
        emit(ChatsStates.inProgress(currentStateModel));
        break;
      case Chats$ErrorState():
        emit(ChatsStates.error(currentStateModel));
        break;
      case Chats$SuccessfulState():
        emit(ChatsStates.successful(currentStateModel));
        break;
    }
  }

  List<ChatModel> _addChat({
    required ChatModel? chat,
    required List<ChatModel> currentChats,
    UserModel? user,
  }) {
    if (chat == null) return currentChats;

    final List<ChatModel> resultChats = List.of(currentChats);

    final convertedToModelChat = _removeCurrentUserFromParticipants(
      chat,
      user,
    );

    final chatIndex = resultChats.indexWhere(
      (e) => e.id == convertedToModelChat.id && e.uuid == convertedToModelChat.uuid,
    );

    if (chatIndex != -1) {
      resultChats[chatIndex] = convertedToModelChat.copyWith(
        lastMessage: chat.lastMessage,
      );
    } else {
      resultChats.add(convertedToModelChat);
    }

    return resultChats;
  }

  ChatModel _removeCurrentUserFromParticipants(ChatModel chatModel, UserModel? user) {
    final data = List<ChatParticipantModel>.from(
      chatModel.participants ?? <ChatParticipantModel>[],
    );

    data.removeWhere((e) => e.user?.id == user?.id);

    chatModel = chatModel.copyWith(participants: data);

    return chatModel;
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
