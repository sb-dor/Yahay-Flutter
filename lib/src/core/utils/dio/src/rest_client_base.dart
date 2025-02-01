import 'package:dio/dio.dart';
import 'exceptions/rest_client_exception.dart';
import 'rest_client.dart';

enum DioMethod { get, post, put, delete }

abstract base class RestClientBase implements RestClient {
  //
  RestClientBase({required String baseURL}) : _baseURL = Uri.parse(baseURL);

  final Uri _baseURL;

  Future<Map<String, Object?>?> send({
    required String path,
    required DioMethod method,
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  @override
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.get,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> post(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.post,
        data: data,
        formData: formData,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.put,
        data: data,
        formData: formData,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.delete,
        data: data,
        formData: formData,
        headers: headers,
        queryParams: queryParams,
      );

  Uri buildUri({required String path, Map<String, String?>? queryParams}) {
    final String finalPath = Uri.parse("${_baseURL.path}/api$path").normalizePath().toString();

    final Map<String, Object?> params = Map.of(_baseURL.queryParameters);

    if (queryParams != null) {
      params.addAll(queryParams);
      params.removeWhere((key, value) => value == null);
    }

    return _baseURL.replace(
      path: finalPath,
      queryParameters: params.isEmpty ? null : params,
    );
  }

  Future<Map<String, Object?>?> decodeResponse(
    final Map<String, Object?>? data, {
    final int? statusCode,
  }) async {
    try {
      if (data case {"data": final Map<String, Object?> data}) {
        return data;
      }

      if (data case {"error": final Map<String, Object?> error}) {
        throw StructuredBackendException(error: error);
      }

      return data;
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
}
