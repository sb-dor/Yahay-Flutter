import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvHelper {
  static DotEnvHelper? _instance;

  static DotEnvHelper get instance => _instance ??= DotEnvHelper._();

  DotEnvHelper._();

  late final DotEnv dotEnv;

  Future<void> initEnv() async {
    dotEnv = DotEnv();
    await dotEnv.load(fileName: ".env");
  }
}
