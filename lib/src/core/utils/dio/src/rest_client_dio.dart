import 'package:dio/dio.dart';
import 'package:yahay/src/core/utils/dio/src/exceptions/rest_client_exception.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';

final class RestClientDio extends RestClientBase {
  //
  RestClientDio({required super.baseURL, Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<Map<String, Object?>?> send({
    required String path,
    required DioMethod method,
    Map<String, Object?>? body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final uri = buildUri(path: path, queryParams: queryParams);
      final request = await _dio.requestUri(
        uri,
        data: body,
        options: Options(
          method: method.name.toUpperCase(),
          headers: headers,
        ),
      );

      // link
      // https://github.com/hawkkiller/sizzle_starter/blob/main/packages/rest_client/lib/src/rest_client_base.dart
      final decodedBody = request.data as Map<String, Object?>;

      if (decodedBody case {"data": final Map<String, Object?> data}) {
        return decodedBody;
      }

      if (decodedBody case {"error": final Map<String, Object?> error}) {
        throw StructuredBackendException(error: error);
      }

      return decodedBody;
    } on DioException catch (error, stackTrace) {
      //

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
}
