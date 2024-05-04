import 'package:dio/dio.dart';
import 'package:yahay/core/utils/shared_preferences.dart';
import 'package:yahay/injections/injections.dart';

class DioSettings {
  final String _mainUrl = "192.168.100.244:8000/api";

  late final Dio dio;

  DioSettings() {
    init();
  }

  Future<Map<String, String>> headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${snoopy.get<SharedPreferHelper>().getStringByKey(key: 'token')}'
    };
  }

  Future<void> init() async {
    final baseOptions = BaseOptions(
      baseUrl: _mainUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: await headers(),
    );
    dio = Dio(baseOptions);
  }
}
