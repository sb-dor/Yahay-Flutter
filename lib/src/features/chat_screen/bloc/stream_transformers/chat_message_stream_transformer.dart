import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/features/chat_screen/bloc/stream_transformers/models/chat_message_transformer.dart';

// TODO: write code that returns or chatMessage or chat itself
final class ChatMessageStreamTransformer
    extends StreamTransformerBase<ChannelReadEvent, ChatMessageTransformer> {
  //
  ChatMessageStreamTransformer({required final Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  Stream<ChatMessageTransformer> bind(Stream<ChannelReadEvent> stream) {
    StreamSubscription? subscription;

    final controller = StreamController<ChatMessageTransformer>(
      onResume: () => subscription?.resume(),
      onCancel: () => subscription?.cancel(),
      onPause: () => subscription?.pause(),
    );

    subscription = stream.listen(
      (event) {
        Map<String, dynamic> messageJson = jsonDecode(event.data ?? '');

        ChatMessageTransformer chatMessageTransformer = const ChatMessageTransformer();

        if (messageJson.containsKey('message') && messageJson['message'] != null) {
          ChatMessageModel message =
              ChatMessageModel.fromJson(messageJson['message']).copyWith(messageSent: true);
          chatMessageTransformer = chatMessageTransformer.copyWith(
            chatMessageModel: message,
          );
        }

        // find problem here
        if (messageJson.containsKey('chat') && messageJson['chat'] != null) {
          _logger.log(
            Level.debug,
            "chat has chat room: ${chatMessageTransformer.chatModel?.videoChatRoom}",
          );
          ChatModel chat = ChatModel.fromJson(messageJson['chat']);

          chatMessageTransformer = chatMessageTransformer.copyWith(chatModel: chat);

          _logger.log(
            Level.debug,
            "chat has chat room 2: ${chatMessageTransformer.chatModel?.videoChatRoom}",
          );
        }

        controller.add(
          chatMessageTransformer,
        );
      },
      onError: (error) => controller.addError(error),
      onDone: () => controller.close(),
    );

    return controller.stream;
  }
}
