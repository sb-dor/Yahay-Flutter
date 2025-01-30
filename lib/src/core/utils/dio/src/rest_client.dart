abstract interface class RestClient {
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> post(
    String path, {
    required Map<String, Object?> data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> put(
    String path, {
    required Map<String, Object?> data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? data,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });
}
