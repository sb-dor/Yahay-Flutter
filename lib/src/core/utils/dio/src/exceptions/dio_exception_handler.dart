import 'package:dio/dio.dart';

final class DioExceptionHandler implements Exception {
  DioExceptionHandler(this.dioException);

  final DioException dioException;

  @override
  String toString() {
    return "DioExceptionHandler: SERVER_ERROR: ${dioException.response?.data}"
        " | MESSAGE: ${dioException.message} | ERROR: ${dioException.error}"
        " | STATUS_MESSAGE: ${dioException.response?.statusMessage}"
        " | STATUS_CODE: ${dioException.response?.statusCode}"
        " | STACKTRACE: ${dioException.stackTrace}"
        " | DIO_EXCEPTION_TYPE: ${dioException.type}"
        " | REAL_URI: ${dioException.response?.realUri}";
  }
}
