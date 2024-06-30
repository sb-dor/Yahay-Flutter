import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/injections/injections.dart';

class PusherClientService {
  final DotEnvHelper _envHelper = snoopy<DotEnvHelper>();

  late final PusherChannelsOptions _options;

  PusherChannelsOptions get options => _options;

  Future<void> init() async {
    // just for showing logs
    PusherChannelsPackageLogger.enableLogs();

    _options = PusherChannelsOptions.fromHost(
      scheme: _envHelper.dotEnv.get('PUSHER_SCHEME'), // should be -> ws
      host: _envHelper.dotEnv.get('PUSHER_HOST'),
      port: int.parse(_envHelper.dotEnv.get("PUSHER_PORT")),
      key: _envHelper.dotEnv.get("PUSHER_APP_KEY"),
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
