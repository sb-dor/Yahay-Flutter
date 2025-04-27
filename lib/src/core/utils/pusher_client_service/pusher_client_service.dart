import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/src/features/initialization/models/application_config.dart';

class PusherClientService {
  PusherClientService(this.applicationConfig);

  final ApplicationConfig applicationConfig;

  late final PusherChannelsOptions _options;

  PusherChannelsOptions get options => _options;

  Future<void> init() async {
    // just for showing logs
    PusherChannelsPackageLogger.enableLogs();

    _options =  PusherChannelsOptions.fromHost(
      scheme: applicationConfig.pusherScheme, // should be -> ws
      host: applicationConfig.pusherHost,
      port: applicationConfig.pusherPort,
      key: applicationConfig.pusherAppKey,
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
