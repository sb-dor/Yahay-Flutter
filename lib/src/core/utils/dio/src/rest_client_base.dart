import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'exceptions/rest_client_exception.dart';
import 'rest_client.dart';

enum DioMethod { get, post, put, delete }

abstract base class RestClientBase implements RestClient {
  //
  RestClientBase({required String baseURL}) : _baseURL = Uri.parse(baseURL);

  final Uri _baseURL;

  static final _jsonUTF8 = json.fuse(utf8);

  Future<Map<String, Object?>?> send({
    required String path,
    required DioMethod method,
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool log,
  });

  @override
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool log = false,
  }) =>
      send(path: path, method: DioMethod.get, headers: headers, queryParams: queryParams, log: log);

  @override
  Future<Map<String, Object?>?> post(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool log = false,
  }) => send(
    path: path,
    method: DioMethod.post,
    data: data,
    formData: formData,
    headers: headers,
    queryParams: queryParams,
    log: log,
  );

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool log = false,
  }) => send(
    path: path,
    method: DioMethod.put,
    data: data,
    formData: formData,
    headers: headers,
    queryParams: queryParams,
    log: log,
  );

  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool log = false,
  }) => send(
    path: path,
    method: DioMethod.delete,
    data: data,
    formData: formData,
    headers: headers,
    queryParams: queryParams,
    log: log,
  );

  Uri buildUri({required String path, Map<String, String?>? queryParams}) {
    final String finalPath = Uri.parse("${_baseURL.path}/api$path").normalizePath().toString();

    final Map<String, Object?> params = Map.of(_baseURL.queryParameters);

    if (queryParams != null) {
      params.addAll(queryParams);
      params.removeWhere((key, value) => value == null);
    }

    return _baseURL.replace(path: finalPath, queryParameters: params.isEmpty ? null : params);
  }

  Future<Map<String, Object?>?> decodeResponse(
    final ResponseBody<Object?>? data, {
    final int? statusCode,
  }) async {
    try {
      final decodedResponse = switch (data) {
        StringResponseBody(body: final String body) => await _decodeString(body),
        BytesResponseBody(body: final List<int> bytes) => await _decodeBytes(bytes),
        MapResponseBody(body: final Map<String, dynamic> map) => map,
        _ => <String, dynamic>{},
      };

      if (decodedResponse case {"data": final Map<String, Object?> data}) {
        return data;
      }

      if (decodedResponse case {"error": final Map<String, Object?> error}) {
        throw StructuredBackendException(error: error);
      }

      return decodedResponse;
    } on RestClientException {
      rethrow;
    } on Object catch (error, stackTrace) {
      //
      Error.throwWithStackTrace(
        ClientException(
          message: "Error occurred during decoding",
          statusCode: statusCode,
          cause: error,
        ),
        stackTrace,
      );
    }
  }

  Future<Map<String, dynamic>?> _decodeString(String data) async {
    if (data.isEmpty) return null;

    if (data.length > 1000) {
      return (await compute(jsonDecode, data)) as Map<String, dynamic>;
    }

    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>?> _decodeBytes(List<int> bytes) async {
    if (bytes.isEmpty) return null;

    if (bytes.length > 1000) {
      return (await compute(_jsonUTF8.decode, bytes)) as Map<String, dynamic>;
    }

    return _jsonUTF8.decode(bytes) as Map<String, dynamic>;
  }
}

sealed class ResponseBody<T> {
  ResponseBody({required this.body});

  T? body;
}

final class StringResponseBody extends ResponseBody<String> {
  StringResponseBody({required super.body});
}

final class BytesResponseBody extends ResponseBody<List<int>> {
  BytesResponseBody({required super.body});
}

final class MapResponseBody extends ResponseBody<Map<String, dynamic>> {
  MapResponseBody({required super.body});
}
