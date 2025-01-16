import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';

import 'state_model/chat_screen_state_model.dart';

part 'chat_screen_bloc.freezed.dart';

@immutable
@freezed
abstract class ChatScreenEvents with _$ChatScreenEvents {
  // init chat on entering to the screen (if chat was already created)
  const factory ChatScreenEvents.initChatScreenEvent({
    final Chat? chat,
    final User? user, // temp for creating temp chat if chat does not exist
  }) = _InitChatScreenEvent;

  const factory ChatScreenEvents.removeAllTempCreatedChatsEvent() = _RemoveAllTempCreatedChatsEvent;

  const factory ChatScreenEvents.handleChatMessageEvent(ChannelReadEvent event) =
      _HandleChatMessageEvent;

  const factory ChatScreenEvents.sendMessageEvent({
    required final String message,
    required void Function() clearMessage,
  }) = _SendMessageEvent;

  const factory ChatScreenEvents.changeEmojiPicker({
    final bool? value,
  }) = _ChangeEmojiPicker;
}

@immutable
@freezed
sealed class ChatScreenStates with _$ChatScreenStates {
  const factory ChatScreenStates.initial(final ChatScreenStateModel chatScreenStateModel) =
      InitialChatScreenState;

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
        removeAllTempCreatedChatsEvent: (event) => _removeAllTempCreatedChatsEvent(event, emit),
        handleChatMessageEvent: (event) => _handleChatMessageEvent(event, emit),
        sendMessageEvent: (event) => _sendMessageEvent(event, emit),
        changeEmojiPicker: (event) => _changeEmojiPicker(event, emit),
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
        currentStateModel = _setChat(currentStateModel: currentStateModel, chat: null);
        emit(ChatScreenStates.error(currentStateModel));
        return;
      }

      currentStateModel = _setChat(currentStateModel: currentStateModel, chat: chat);

      final channelName =
          "${Constants.chatChannelName}${chat.id}${Constants.chatChannelUUID}${chat.uuid}";

      debugPrint("channel name: $channelName");

      currentStateModel = _setPusherChannel(
        client: PusherChannelsClient.websocket(
          options: _options,
          connectionErrorHandler: (f, s, t) {},
        ),
        currentStateModel: currentStateModel,
      );

      final channel = currentStateModel.pusherChannelsClient?.publicChannel(channelName);

      final subs = currentStateModel.pusherChannelsClient?.onConnectionEstablished.listen(
        (e) {
          channel?.subscribeIfNotUnsubscribed();
        },
      );

      currentStateModel = _setToSubscription(
        subs: subs,
        chatScreenStateModel: currentStateModel,
      );

      await currentStateModel.pusherChannelsClient?.connect();

      channel?.bind(Constants.chatChannelEventName).listen((pusherEvent) {
        add(ChatScreenEvents.handleChatMessageEvent(pusherEvent));
      });

      emit(ChatScreenStates.loaded(currentStateModel));

      // get all chat messages here
    } catch (e) {
      debugPrint("channel connecting error: $e");
      emit(ChatScreenStates.error(currentStateModel));
    }
  }

  void _removeAllTempCreatedChatsEvent(
    _RemoveAllTempCreatedChatsEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    try {
      _iChatScreenChatRepo.removeAllTempCreatedChats(
        chat: state.chatScreenStateModel.currentChat,
      );
    } catch (e) {
      debugPrint("_removeAllTempCreatedChatsEvent error is: $e");
    }
  }

  void _handleChatMessageEvent(
    _HandleChatMessageEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();
    try {
      Map<String, dynamic> messageJson = jsonDecode(event.event.data ?? '');

      if (messageJson.containsKey('message') && messageJson['message'] != null) {
        ChatMessageModel message =
            ChatMessageModel.fromJson(messageJson['message']).copyWith(messageSent: true);
        currentStateModel = _addMessage(
          message: message,
          currentStateModel: currentStateModel,
        );
      }

      // find problem here
      if (messageJson.containsKey('chat') && messageJson['chat'] != null) {
        debugPrint("chat has chat room: ${currentStateModel.currentChat?.videoChatRoom}");
        ChatModel chat = ChatModel.fromJson(messageJson['chat']);
        final currentChatFromModel = ChatModel.fromEntity(currentStateModel.currentChat);
        currentStateModel = _setChat(
          chat: currentChatFromModel?.copyWith(
            videoChatRoom: chat.videoChatRoom,
            videoChatStreaming: chat.videoChatStreaming,
          ),
          setChatMessages: false,
          currentStateModel: currentStateModel,
        );
        debugPrint("chat has chat room 2: ${currentStateModel.currentChat?.videoChatRoom}");
      }

      _emitter(emit: emit, currentStateModel: currentStateModel);
    } catch (e) {
      emit(ChatScreenStates.error(currentStateModel));
    }
  }

  void _sendMessageEvent(
    _SendMessageEvent event,
    Emitter<ChatScreenStates> emit,
  ) async {
    var currentStateModel = state.chatScreenStateModel.copyWith();
    try {
      if (currentStateModel.pickedFile == null) {
        return;
      }

      final chatMessage = ChatMessageModel(
        chat: ChatModel.fromEntity(currentStateModel.currentChat),
        user: UserModel.fromEntity(currentStateModel.currentUser),
        relatedToUser: UserModel.fromEntity(currentStateModel.relatedUser),
        message: event.message.trim(),
        chatMessageUUID: const Uuid().v4(),
        file: currentStateModel.pickedFile,
        createdAt: DateTime.now().toString().substring(0, 19),
        messageSent: false,
      );

      currentStateModel = _addMessage(
        message: chatMessage,
        currentStateModel: currentStateModel,
      );

      event.clearMessage();

      _emitter(emit: emit, currentStateModel: currentStateModel);

      await _iChatScreenRepo.sendMessage(
        chatMessage: chatMessage,
      );
    } catch (e) {
      emit(ChatScreenStates.error(currentStateModel));
    }
  }

  void _changeEmojiPicker(
    _ChangeEmojiPicker event,
    Emitter<ChatScreenStates> emit,
  ) async {
    try {
      var currentStateModel = _changeEmojiPickerHelper(
        currentStateModel: state.chatScreenStateModel,
        value: event.value,
      );
      _emitter(emit: emit, currentStateModel: currentStateModel);
    } catch (e) {
      debugPrint("_chaneEmojiPicker error is: $e");
    }
  }

  // logic
  ChatScreenStateModel _setChat({
    required ChatScreenStateModel currentStateModel,
    Chat? chat,
    bool setChatMessages = true,
  }) {
    if (chat == null) return currentStateModel;
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
    return currentStateModel;
  }

//
// void setToFile(File? file) => _pickedFile = file;
//
// void setToRelatedUser(User? user) => _relatedUser = user;
//
// void setToCurrentUser(User? user) => _currentUser = user;
//
  ChatScreenStateModel _addMessage({
    required ChatMessage message,
    required ChatScreenStateModel currentStateModel,
  }) {
    final listOfMessages = List<ChatMessage>.from(currentStateModel.messages);

    final findMessage =
        listOfMessages.firstWhereOrNull((e) => e.chatMessageUUID == message.chatMessageUUID);
    if (findMessage != null) {
      listOfMessages[
              listOfMessages.indexWhere((e) => e.chatMessageUUID == message.chatMessageUUID)] =
          ChatMessageModel.fromEntity(findMessage)!.copyWith(messageSent: true);
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

//
  ChatScreenStateModel _setPusherChannel({
    required PusherChannelsClient client,
    required ChatScreenStateModel currentStateModel,
  }) {
    return currentStateModel = currentStateModel.copyWith(
      pusherChannelsClient: client,
    );
  }

//
  ChatScreenStateModel _setToSubscription({
    required StreamSubscription<void>? subs,
    required ChatScreenStateModel chatScreenStateModel,
  }) {
    return chatScreenStateModel = chatScreenStateModel.copyWith(
      channelSubscription: subs,
    );
  }

  void _emitter({
    required Emitter<ChatScreenStates> emit,
    required ChatScreenStateModel currentStateModel,
  }) {
    switch (state) {
      case InitialChatScreenState():
        emit(ChatScreenStates.initial(currentStateModel));
      case LoadingChatScreenState():
        emit(ChatScreenStates.loading(currentStateModel));
        break;
      case ErrorChatScreenState():
        emit(ChatScreenStates.error(currentStateModel));
        break;
      case LoadedChatScreenState():
        emit(ChatScreenStates.loaded(currentStateModel));
        break;
    }
  }

  @override
  Future<void> close() async {
    await state.chatScreenStateModel.pusherChannelsClient?.disconnect();
    await state.chatScreenStateModel.channelSubscription?.cancel();
    state.chatScreenStateModel.pusherChannelsClient?.dispose();
    return super.close();
  }
}
