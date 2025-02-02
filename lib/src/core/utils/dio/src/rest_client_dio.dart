import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/utils/dio/src/exceptions/rest_client_exception.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';

final class RestClientDio extends RestClientBase {
  //
  RestClientDio({
    required super.baseURL,
    required final SharedPreferHelper sharedPrefer,
    required final Logger logger,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        _sharedPreferHelper = sharedPrefer,
        _logger = logger;

  final Dio _dio;
  final SharedPreferHelper _sharedPreferHelper;
  final Logger _logger;

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

      _logger.log(Level.debug, "building uri: $uri");

      final request = await _dio.requestUri(
        uri,
        data: formData ?? data,
        options: Options(
          method: method.name.toUpperCase(),
          headers: headers ?? await this.headers,
        ),
      );

      _logger.log(Level.debug, request);

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
      _logger.log(Level.error, error);
      if (error.response?.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(
          exception: error,
          statusCode: 401,
        );
      }

      Error.throwWithStackTrace(
        DioExceptionHandler(dioException: error),
        stackTrace,
      );
      //
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
