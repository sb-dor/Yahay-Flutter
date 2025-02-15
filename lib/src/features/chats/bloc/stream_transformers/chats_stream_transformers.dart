import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';

class ChatsStreamTransformers extends StreamTransformerBase<ChannelReadEvent, ChatModel> {
  //
  ChatsStreamTransformers({required final Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  Stream<ChatModel> bind(Stream<ChannelReadEvent?> stream) {
    StreamSubscription? subscription;
    final controller = StreamController<ChatModel>(
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
      onCancel: () => subscription?.cancel(),
    );

    subscription = stream.listen(
      (event) {
        final data = event?.data;

        _logger.log(
          Level.debug,
          "$data",
        );

        final Map<String, dynamic> json = data is String
            ? jsonDecode(data)
            : data is Map
                ? data
                : {};

        if (json['chat'] != null) {
          final ChatModel chat = ChatModel.fromJson(json['chat']);
          controller.add(chat);
        }
      },
      onDone: controller.close,
      onError: (error) => controller.addError(error),
    );

    return controller.stream;
  }
}
