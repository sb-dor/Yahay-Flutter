import 'package:pusher_client/pusher_client.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/injections/injections.dart';

class PusherClientService {
  final DotEnvHelper _envHelper = snoopy<DotEnvHelper>();

  late final PusherClient pusherClient;

  PusherClientService() {
    init();
  }

  void init() async {
    final options = PusherOptions(
      host: _envHelper.dotEnv.get('PUSHER_HOST'),
      wsPort: int.parse(_envHelper.dotEnv.get("PUSHER_PORT")),
      encrypted: false,
    );

    pusherClient = PusherClient(
      _envHelper.dotEnv.get("PUSHER_APP_KEY"),
      options,
    );
  }
}
