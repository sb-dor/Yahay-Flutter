import 'package:dio/dio.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/injections/injections.dart';

class DioSettings {
  final String _mainUrl = snoopy<DotEnvHelper>().dotEnv.get('MAIN_URL');

  late final Dio dio;

  Future<Map<String, String>> headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${snoopy.get<SharedPreferHelper>().getStringByKey(key: 'token')}'
    };
  }

  Future<BaseOptions> _options() async {
    return BaseOptions(
      baseUrl: _mainUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: await headers(),
      queryParameters: {
        "per_page": Constants.perPage,
      },
    );
  }

  Future<void> init() async {
    dio = Dio(await _options());
  }

  Future<void> updateDio() async {
    dio.options = await _options();
  }
}
