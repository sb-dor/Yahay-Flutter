import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';

class PusherClientService {
  late final PusherChannelsOptions _options;

  PusherChannelsOptions get options => _options;

  Future<void> init() async {
    final DotEnvHelper envHelper = DotEnvHelper.instance;
    // just for showing logs
    PusherChannelsPackageLogger.enableLogs();

    _options = PusherChannelsOptions.fromHost(
      scheme: envHelper.dotEnv.get('PUSHER_SCHEME'), // should be -> ws
      host: envHelper.dotEnv.get('PUSHER_HOST'),
      port: int.parse(envHelper.dotEnv.get("PUSHER_PORT")),
      key: envHelper.dotEnv.get("PUSHER_APP_KEY"),
    );
  }

  Future<PusherChannelsClient> subscriptionCreator() async {
    final pusherChannelClient = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (f, s, t) {},
    );

    return pusherChannelClient;
  }
}
