import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_participant.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chat_participant_model/chat_participant_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';
import 'state_model/chats_state_model.dart';

part 'chats_bloc.freezed.dart';

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

      emit(ChatsStates.loadingChatsState(state.chatsStateModel));

      var currentStateModel = state.chatsStateModel.copyWith(
        chats: await _chatsRepo.chats(),
      );

      _logger.log(Level.debug, "chat length is: ${currentStateModel.chats.length}");

      emit(ChatsStates.loadedChatsState(currentStateModel));
    } catch (e) {
      _logger.log(Level.error, "_getUserChatsEvent error is: $e");
      emit(ChatsStates.errorChatsState(state.chatsStateModel));
    }
  }

  void _chatListenerInitialEvent(
    _ChatListenerInitialEvent event,
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

      _logger.log(Level.debug, "is this chat: $chat");

      // debugPrint("chat room decoded data: ${jsonDecode(chat.videoChatRoom?.offer ?? '')}");

      var currentStateModel = state.chatsStateModel.copyWith(
        chats: addChat(chat: chat, currentChats: state.chatsStateModel.chats),
      );

      _emitter(currentStateModel: currentStateModel, emit: emit);
    } catch (e) {
      _logger.log(Level.error, "_channelListenerEvent error is: $e");
    }
  }

  void _changeToLoadingState(
    _ChangeToLoadingState event,
    Emitter<ChatsStates> emit,
  ) async {
    var currentState = state.chatsStateModel.copyWith(chats: <Chat>[]);
    _emitter(currentStateModel: currentState, emit: emit);
  }

  void _emitter({
    required ChatsStateModel currentStateModel,
    required Emitter<ChatsStates> emit,
  }) {
    switch (state) {
      case InitialChatsState():
        emit(ChatsStates.initial(currentStateModel));
        break;
      case LoadingChatsState():
        emit(ChatsStates.loadingChatsState(currentStateModel));
        break;
      case ErrorChatsState():
        emit(ChatsStates.errorChatsState(currentStateModel));
        break;
      case LoadedChatsState():
        emit(ChatsStates.loadedChatsState(currentStateModel));
        break;
    }
  }

  List<Chat> addChat({
    required Chat chat,
    required List<Chat> currentChats,
    User? user,
  }) {
    var convertedToModelChat = ChatModel.fromEntity(chat);

    if (convertedToModelChat == null) return currentChats;

    final List<Chat> resultChats = List.of(currentChats);

    convertedToModelChat = _removeCurrentUserFromParticipants(
      convertedToModelChat,
      user,
    );

    final chatIndex = resultChats.indexWhere(
      (e) => e.id == convertedToModelChat?.id && e.uuid == convertedToModelChat?.uuid,
    );

    if (chatIndex != -1) {
      resultChats[chatIndex] = convertedToModelChat.copyWith(
        lastMessage: ChatMessageModel.fromEntity(chat.lastMessage),
      );
    } else {
      resultChats.add(convertedToModelChat);
    }

    return resultChats;
  }

  ChatModel _removeCurrentUserFromParticipants(ChatModel chatModel, User? user) {
    final data = List<ChatParticipantModel>.from(chatModel.participants ?? <ChatParticipant>[]);

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
