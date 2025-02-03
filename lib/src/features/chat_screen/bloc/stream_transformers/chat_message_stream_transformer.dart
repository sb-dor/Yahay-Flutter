import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';

// TODO: write code that returns or chatMessage or chat itself
final class ChatMessageStreamTransformer
    extends StreamTransformerBase<ChannelReadEvent, ChatMessageModel> {
  //
  ChatMessageStreamTransformer({required final Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  Stream<ChatMessageModel> bind(Stream<ChannelReadEvent> stream) {
    StreamSubscription? subscription;

    final controller = StreamController<ChatMessageModel>(
      onResume: () => subscription?.resume(),
      onCancel: () => subscription?.cancel(),
      onPause: () => subscription?.pause(),
    );

    subscription = stream.listen(
      (event) {
        Map<String, dynamic> messageJson = jsonDecode(event.data ?? '');

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
          _logger.log(
            Level.debug,
            "chat has chat room: ${currentStateModel.currentChat?.videoChatRoom}",
          );
          ChatModel chat = ChatModel.fromJson(messageJson['chat']);
          currentStateModel = _setChat(
            chat: currentStateModel.currentChat?.copyWith(
              videoChatRoom: chat.videoChatRoom,
              videoChatStreaming: chat.videoChatStreaming,
            ),
            setChatMessages: false,
            currentStateModel: currentStateModel,
          );
          _logger.log(
            Level.debug,
            "chat has chat room 2: ${currentStateModel.currentChat?.videoChatRoom}",
          );
        }

        controller.add(
          ChatMessageModel(),
        );
      },
      onError: (error) => controller.addError(error),
      onDone: () => controller.close(),
    );

    return controller.stream;
  }
}
