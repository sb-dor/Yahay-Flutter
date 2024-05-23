import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/injections/injections.dart';

// class PusherClientService {
//   final DotEnvHelper _envHelper = snoopy<DotEnvHelper>();
//
//   late final PusherClient pusherClient;
//
//   PusherClientService() {
//     init();
//   }
//
//   void init() async {
//     final options = PusherOptions(
//       host: _envHelper.dotEnv.get('PUSHER_HOST'),
//       wsPort: int.parse(_envHelper.dotEnv.get("PUSHER_PORT")),
//       encrypted: false,
//     );
//
//     pusherClient = PusherClient(
//       _envHelper.dotEnv.get("PUSHER_APP_KEY"),
//       options,
//     );
//   }
// }

class PusherClientService {
  final DotEnvHelper _envHelper = snoopy<DotEnvHelper>();

  late final PusherChannelsClient pusherClient;

  Future<void> init() async {
    PusherChannelsPackageLogger.enableLogs();

    final options = PusherChannelsOptions.fromHost(
      scheme: _envHelper.dotEnv.get('PUSHER_SCHEME'),
      host: _envHelper.dotEnv.get('PUSHER_HOST'),
      port: int.parse(_envHelper.dotEnv.get("PUSHER_PORT")),
      key: _envHelper.dotEnv.get("PUSHER_APP_KEY"),
    );

    pusherClient = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (f, s, t) {
        debugPrint("error is: $f");
      },
    );

    await pusherClient.connect();

    pusherClient.pusherErrorEventStream.listen((e) {
      debugPrint("error of pusher is: ${e.data}");
    });
  }
}
