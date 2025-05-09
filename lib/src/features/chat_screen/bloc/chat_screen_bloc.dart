import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';

import 'state_model/chat_screen_state_model.dart';
import 'stream_transformers/chat_message_stream_transformer.dart';

part 'chat_screen_bloc.freezed.dart';

@immutable
@freezed
sealed class ChatScreenEvents with _$ChatScreenEvents {
  // init chat on entering to the screen (if chat was already created)
  const factory ChatScreenEvents.initChatScreenEvent({
    final ChatModel? chat,
    final UserModel? user, // temp for creating temp chat if chat does not exist
  }) = _ChatScreen$InitEvent;

  const factory ChatScreenEvents.removeAllTempCreatedChatsEvent() =
      _ChatsScreen$RemoveAllTempCreatedEvent;

  const factory ChatScreenEvents.handleChatMessageEvent(
    ChatMessageStreamTransformerRecord chatMessageTransformer,
  ) = _Chat$HandleMessageEvent;

  const factory ChatScreenEvents.sendMessageEvent({
    required final String message,
    required void Function() clearMessage,
  }) = _Chat$SendMessageEvent;

  const factory ChatScreenEvents.changeEmojiPicker({final bool? value}) =
      _Chat$ChangeEmojiPickerEvent;
}

@immutable
@freezed
sealed class ChatScreenStates with _$ChatScreenStates {
  const factory ChatScreenStates.initial(final ChatScreenStateModel chatScreenStateModel) =
      ChatScreen$InitialState;

  const factory ChatScreenStates.inProgress(final ChatScreenStateModel chatScreenStateModel) =
      ChatScreen$InProgressState;

  const factory ChatScreenStates.error(final ChatScreenStateModel chatScreenStateModel) =
      ErrorChatScreenState;

  const factory ChatScreenStates.successful(final ChatScreenStateModel chatScreenStateModel) =
      ChatScreen$SuccessfulState;
}

class ChatScreenBloc extends Bloc<ChatScreenEvents, ChatScreenStates> {
  //
  PusherChannelsClient? _pusherChannelsClient;
  StreamSubscription<void>? _channelSubscription;
  StreamSubscription<void>? _channelInformationSubscription;

  //
  final ChatScreenRepo _iChatScreenRepo;
  final ChatScreenChatRepo _iChatScreenChatRepo;
  final UserModel? _currentUser;
  final PusherChannelsOptions _options;
  final Logger _logger;

  ChatScreenBloc({
    required ChatScreenRepo chatScreenRepo,
    required ChatScreenChatRepo chatScreenChatRepo,
    required UserModel? currentUser,
    required PusherChannelsOptions options,
    required ChatScreenStates initialState,
    required Logger logger,
  }) : _iChatScreenRepo = chatScreenRepo,
       _iChatScreenChatRepo = chatScreenChatRepo,
       _currentUser = currentUser,
       _options = options,
       _logger = logger,
       super(initialState) {
    //
    on<ChatScreenEvents>(
      (event, emit) => event.map(
        initChatScreenEvent: (event) => _initChatScreenEvent(event, emit),
        removeAllTempCreatedChatsEvent: (event) => _removeAllTempCreatedChatsEvent(event, emit),
        handleChatMessageEvent: (event) => _handleChatMessageEvent(event, emit),
        sendMessageEvent: (event) => _sendMessageEvent(event, emit),
        changeEmojiPicker: (event) => _changeEmojiPicker(event, emit),
      ),
    );
    //
  }

  void _initChatScreenEvent(_ChatScreen$InitEvent event, Emitter<ChatScreenStates> emit) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();

    emit(ChatScreenStates.inProgress(currentStateModel));

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
      currentStateModel = _setChat(currentStateModel: currentStateModel, chat: null);
      emit(ChatScreenStates.error(currentStateModel));
      return;
    }

    currentStateModel = _setChat(currentStateModel: currentStateModel, chat: chat);

    final channelName =
        "${Constants.chatChannelName}${chat.id}${Constants.chatChannelUUID}${chat.uuid}";

    debugPrint("channel name: $channelName");

    _pusherChannelsClient = PusherChannelsClient.websocket(
      options: _options,
      connectionErrorHandler: (f, s, t) {},
    );

    final channel = _pusherChannelsClient?.publicChannel(channelName);

    _channelInformationSubscription = _pusherChannelsClient?.onConnectionEstablished.listen((e) {
      channel?.subscribeIfNotUnsubscribed();
    });

    await _pusherChannelsClient?.connect();

    _channelSubscription = channel
        ?.bind(Constants.chatChannelEventName)
        .transform(ChatMessageStreamTransformer(logger: _logger))
        .listen(
          (pusherEvent) {
            add(ChatScreenEvents.handleChatMessageEvent(pusherEvent));
          },
          onError: (error, stackTrace) => Error.throwWithStackTrace(error, stackTrace),
          onDone: () => _channelSubscription?.cancel(),
        );

    emit(ChatScreenStates.successful(currentStateModel));

    // get all chat messages here
  }

  void _removeAllTempCreatedChatsEvent(
    _ChatsScreen$RemoveAllTempCreatedEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    _iChatScreenChatRepo.removeAllTempCreatedChats(chat: state.chatScreenStateModel.currentChat);
  }

  void _handleChatMessageEvent(
    _Chat$HandleMessageEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();

    // patterns
    final (:chageMessageModel, :chatModel) = event.chatMessageTransformer;

    if (chageMessageModel != null) {
      currentStateModel = _addMessage(
        message: chageMessageModel,
        currentStateModel: currentStateModel,
      );
    }

    // find problem here
    if (chatModel != null) {
      currentStateModel = _setChat(
        chat: currentStateModel.currentChat?.copyWith(
          videoChatRoom: chatModel.videoChatRoom,
          videoChatStreaming: chatModel.videoChatStreaming,
        ),
        setChatMessages: false,
        currentStateModel: currentStateModel,
      );
    }

    _emitter(emit: emit, currentStateModel: currentStateModel);
  }

  void _sendMessageEvent(_Chat$SendMessageEvent event, Emitter<ChatScreenStates> emit) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();
    // if (currentStateModel.pickedFile == null) {
    //   return;
    // }

    final chatMessage = ChatMessageModel(
      chat: currentStateModel.currentChat,
      user: currentStateModel.currentUser,
      relatedToUser: currentStateModel.relatedUser,
      message: event.message.trim(),
      chatMessageUUID: const Uuid().v4(),
      file: currentStateModel.pickedFile,
      createdAt: DateTime.now().toString().substring(0, 19),
      messageSent: false,
    );

    currentStateModel = _addMessage(message: chatMessage, currentStateModel: currentStateModel);

    event.clearMessage();

    _emitter(emit: emit, currentStateModel: currentStateModel);

    await _iChatScreenRepo.sendMessage(chatMessage: chatMessage);
  }

  void _changeEmojiPicker(
    _Chat$ChangeEmojiPickerEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    final currentStateModel = _changeEmojiPickerHelper(
      currentStateModel: state.chatScreenStateModel,
      value: event.value,
    );
    _emitter(emit: emit, currentStateModel: currentStateModel);
  }

  // logic
  ChatScreenStateModel _setChat({
    required ChatScreenStateModel currentStateModel,
    ChatModel? chat,
    bool setChatMessages = true,
  }) {
    if (chat == null) return currentStateModel;
    currentStateModel = currentStateModel.copyWith(currentChat: chat);
    if (setChatMessages) {
      final List<ChatMessageModel> chatMessages = List.from(currentStateModel.messages);
      chatMessages.addAll((chat.messages ?? []).reversed.toList());
      currentStateModel = currentStateModel.copyWith(messages: chatMessages);
    }
    return currentStateModel;
  }

  //
  // void setToFile(File? file) => _pickedFile = file;
  //
  // void setToRelatedUser(UserModel? user) => _relatedUser = user;
  //
  // void setToCurrentUser(UserModel? user) => _currentUser = user;
  //
  ChatScreenStateModel _addMessage({
    required ChatMessageModel message,
    required ChatScreenStateModel currentStateModel,
  }) {
    final listOfMessages = List<ChatMessageModel>.from(currentStateModel.messages);

    final findMessage = listOfMessages.firstWhereOrNull(
      (e) => e.chatMessageUUID == message.chatMessageUUID,
    );
    if (findMessage != null) {
      listOfMessages[listOfMessages.indexWhere(
        (e) => e.chatMessageUUID == message.chatMessageUUID,
      )] = findMessage.copyWith(messageSent: true);
    } else {
      listOfMessages.add(message);
    }

    currentStateModel = currentStateModel.copyWith(messages: listOfMessages);

    return currentStateModel;
  }

  //
  // void clearMessage() => _messageController.clear();
  //
  ChatScreenStateModel _changeEmojiPickerHelper({
    required ChatScreenStateModel currentStateModel,
    bool? value,
  }) {
    return currentStateModel = currentStateModel.copyWith(
      showEmojiPicker: value ?? !currentStateModel.showEmojiPicker,
    );
  }

  void _emitter({
    required Emitter<ChatScreenStates> emit,
    required ChatScreenStateModel currentStateModel,
  }) {
    switch (state) {
      case ChatScreen$InitialState():
        emit(ChatScreenStates.initial(currentStateModel));
        break;
      case ChatScreen$InProgressState():
        emit(ChatScreenStates.inProgress(currentStateModel));
        break;
      case ErrorChatScreenState():
        emit(ChatScreenStates.error(currentStateModel));
        break;
      case ChatScreen$SuccessfulState():
        emit(ChatScreenStates.successful(currentStateModel));
        break;
    }
  }

  @override
  Future<void> close() async {
    add(const ChatScreenEvents.removeAllTempCreatedChatsEvent());
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    await _channelSubscription?.cancel();
    await _channelInformationSubscription?.cancel();
    return super.close();
  }
}
