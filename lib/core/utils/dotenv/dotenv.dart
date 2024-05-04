import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvHelper {
  late final DotEnv dotEnv;

  Future<void> initEnv() async {
    dotEnv.load(fileName: ".env");
  }
}
