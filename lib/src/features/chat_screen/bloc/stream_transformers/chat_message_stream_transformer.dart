import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';

typedef ChatMessageStreamTransformerRecord =
    ({ChatModel? chatModel, ChatMessageModel? chageMessageModel});

// I know that I could create a class that holds chatModel and message
// but in order to improve records i had to write
final class ChatMessageStreamTransformer
    extends StreamTransformerBase<ChannelReadEvent, ChatMessageStreamTransformerRecord> {
  //
  ChatMessageStreamTransformer({required final Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  Stream<ChatMessageStreamTransformerRecord> bind(Stream<ChannelReadEvent> stream) {
    StreamSubscription? subscription;

    final controller = StreamController<ChatMessageStreamTransformerRecord>(
      onResume: () => subscription?.resume(),
      onCancel: () => subscription?.cancel(),
      onPause: () => subscription?.pause(),
    );

    subscription = stream.listen(
      (event) {
        final Map<String, dynamic> messageJson = jsonDecode(event.data ?? '');

        ChatMessageModel? message;
        ChatModel? chat;

        if (messageJson.containsKey('message') && messageJson['message'] != null) {
          message = ChatMessageModel.fromJson(messageJson['message']).copyWith(messageSent: true);
        }

        // find problem here
        if (messageJson.containsKey('chat') && messageJson['chat'] != null) {
          // _logger.log(
          //   Level.debug,
          //   "chat has chat room: ${chatMessageTransformer.chatModel?.videoChatRoom}",
          // );
          chat = ChatModel.fromJson(messageJson['chat']);
          // _logger.log(
          //   Level.debug,
          //   "chat has chat room 2: ${chatMessageTransformer.chatModel?.videoChatRoom}",
          // );
        }

        controller.add((chatModel: chat, chageMessageModel: message));
      },
      onError: (error) => controller.addError(error),
      onDone: controller.close,
    );

    return controller.stream;
  }
}
