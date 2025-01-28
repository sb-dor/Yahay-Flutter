import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/utils/dotenv/dotenv.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';

class DioSettings {
  DioSettings({
    required final SharedPreferHelper sharedPreferHelper,
    required final Logger logger,
    required final Dio dio,
  })  : _sharedPreferHelper = sharedPreferHelper,
        _logger = logger,
        _dio = dio;

  final SharedPreferHelper _sharedPreferHelper;
  final Logger _logger;
  final Dio _dio;

  final String _mainUrl = DotEnvHelper.instance.dotEnv.get('MAIN_URL');

  Dio get dio => _dio;

  Future<Map<String, String>> get headers async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_sharedPreferHelper.getStringByKey(key: 'token')}'
    };
  }

  Future<BaseOptions> _options() async {
    return BaseOptions(
      baseUrl: _mainUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: await headers,
      queryParameters: {
        "per_page": Constants.perPage,
      },
    );
  }

  Future<void> initOptions() async {
    dio.options = await _options();
  }
}
