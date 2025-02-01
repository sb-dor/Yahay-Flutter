import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/src/core/utils/dio/src/exceptions/rest_client_exception.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';

final class RestClientDio extends RestClientBase {
  //
  RestClientDio({
    required super.baseURL,
    required SharedPreferHelper sharedPrefer,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        _sharedPreferHelper = sharedPrefer;

  final Dio _dio;
  final SharedPreferHelper _sharedPreferHelper;

  @override
  Future<Map<String, Object?>?> send({
    required String path,
    required DioMethod method,
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final uri = buildUri(path: path, queryParams: queryParams);

      debugPrint("building uri: $uri");

      final request = await _dio.requestUri(
        uri,
        data: formData ?? data,
        options: Options(
          method: method.name.toUpperCase(),
          headers: headers ?? await this.headers,
        ),
      );

      // link
      // https://github.com/hawkkiller/sizzle_starter/blob/main/packages/rest_client/lib/src/rest_client_base.dart
      return decodeResponse(
        request.data,
        statusCode: request.statusCode,
      );
    } on RestClientException {
      //
      // rethrow also throws error and stacktrace
      rethrow;
    } on DioException catch (error, stackTrace) {
      Exception? exception;

      if (error.response?.statusCode == 401) {
        exception = const UnauthenticatedException(statusCode: 401);
      } else {
        exception = DioExceptionHandler(dioException: error);
      }

      Error.throwWithStackTrace(exception, stackTrace);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<Map<String, String>> get headers async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_sharedPreferHelper.getStringByKey(key: 'token')}'
    };
  }
}
