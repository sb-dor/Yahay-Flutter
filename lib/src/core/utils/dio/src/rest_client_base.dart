import 'package:dio/dio.dart';
import 'exceptions/rest_client_exception.dart';
import 'rest_client.dart';
import 'package:path/path.dart' as p;

enum DioMethod { get, post, put, delete }

abstract base class RestClientBase implements RestClient {
  //
  RestClientBase({required String baseURL}) : _baseURL = Uri.parse(baseURL);

  final Uri _baseURL;

  Future<Map<String, Object?>?> send({
    required String path,
    required DioMethod method,
    Map<String, Object?>? data,
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
    required Map<String, Object?> data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.post,
        data: data,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    required Map<String, Object?> data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.put,
        data: data,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.delete,
        data: data,
        headers: headers,
        queryParams: queryParams,
      );

  Uri buildUri({required String path, Map<String, String?>? queryParams}) {
    final finalPath = p.join(_baseURL.path, path);
    return _baseURL.replace(
      path: finalPath,
      queryParameters: {..._baseURL.queryParameters, ...?queryParams},
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
    } on DioException catch (error, stackTrace) {
      Exception? exception;

      if (error.response?.statusCode == 401) {
        exception = const UnauthenticatedException(statusCode: 401);
      } else {
        exception = DioExceptionHandler(dioException: error);
      }

      Error.throwWithStackTrace(exception, stackTrace);
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
