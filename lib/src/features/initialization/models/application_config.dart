import 'package:yahay/src/features/initialization/models/environment.dart';

class ApplicationConfig {
  const ApplicationConfig();

  // for checking type of environment
  Environment get environment {
    final env = const String.fromEnvironment("ENVIRONMENT").trim();

    return Environment.from(env);
  }

  String get mainUrl => const String.fromEnvironment("MAIN_URL");

  String get pusherAppId => const String.fromEnvironment("PUSHER_APP_ID");

  String get pusherAppKey => const String.fromEnvironment("PUSHER_APP_KEY");

  String get pusherAppSecret => const String.fromEnvironment("PUSHER_APP_SECRET");

  String get pusherHost => const String.fromEnvironment("PUSHER_HOST");

  int get pusherPort => const int.fromEnvironment("PUSHER_PORT");

  String get pusherScheme => const String.fromEnvironment("PUSHER_SCHEME");
}
