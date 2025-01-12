import 'package:dio/dio.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/utils/dotenv/dotenv.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';

class DioSettings {
  static DioSettings? _instance;

  static DioSettings get instance => _instance ??= DioSettings._();

  DioSettings._();

  final String _mainUrl = DotEnvHelper.instance.dotEnv.get('MAIN_URL');

  late final Dio dio;

  Future<Map<String, String>> headers(SharedPreferHelper sharedPreferHelper) async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPreferHelper.getStringByKey(key: 'token')}'
    };
  }

  Future<BaseOptions> _options(SharedPreferHelper sharedPreferHelper) async {
    return BaseOptions(
      baseUrl: _mainUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: await headers(sharedPreferHelper),
      queryParameters: {
        "per_page": Constants.perPage,
      },
    );
  }

  Future<void> init(SharedPreferHelper sharedPreferHelper) async {
    dio = Dio(await _options(sharedPreferHelper));
  }

  Future<void> updateDio(SharedPreferHelper sharedPreferHelper) async {
    dio.options = await _options(sharedPreferHelper);
  }
}
