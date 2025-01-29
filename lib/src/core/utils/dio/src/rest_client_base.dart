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
    Map<String, Object?>? body,
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
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.post,
        body: body,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.put,
        body: body,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) =>
      send(
        path: path,
        method: DioMethod.delete,
        body: body,
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
}
