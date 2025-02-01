import 'package:dio/dio.dart';

abstract interface class RestClient {
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> post(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> put(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? data,
    FormData? formData,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });
}
