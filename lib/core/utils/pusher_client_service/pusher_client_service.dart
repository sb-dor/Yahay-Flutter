import 'package:dart_pusher_channels/dart_pusher_channels.dart';
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

  PusherClientService() {
    init();
  }

  void init() async {
    final options = PusherChannelsOptions.fromCluster(
      scheme: _envHelper.dotEnv.get("PUSHER_SCHEME"),
      cluster: _envHelper.dotEnv.get("PUSHER_APP_CLUSTER"),
      key: _envHelper.dotEnv.get("PUSHER_APP_KEY"),
      host: _envHelper.dotEnv.get("PUSHER_HOST"),
      // shouldSupplyMetadataQueries: true,
      // metadata: const PusherChannelsOptionsMetadata.byDefault(),
      port: int.parse(_envHelper.dotEnv.get("PUSHER_PORT")),
    );

    pusherClient = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (exception, trace, refresh) {
        refresh();
      },
    );

    await pusherClient.connect();
  }
}
