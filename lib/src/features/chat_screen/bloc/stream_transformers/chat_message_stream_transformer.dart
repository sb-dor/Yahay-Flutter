import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';

final class ChatMessageStreamTransformer
    extends StreamTransformerBase<ChannelReadEvent, ChatMessageModel> {
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
