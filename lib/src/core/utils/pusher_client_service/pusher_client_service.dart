import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/env/env.dart';

class PusherClientService {
  late final PusherChannelsOptions _options;

  PusherChannelsOptions get options => _options;

  Future<void> init() async {
    // just for showing logs
    PusherChannelsPackageLogger.enableLogs();

    _options = const PusherChannelsOptions.fromHost(
      scheme: Env.pusherScheme, // should be -> ws
      host: Env.pusherHost,
      port: Env.pusherPort,
      key: Env.pusherAppKey,
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
