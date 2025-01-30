import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

import 'rest_client_exception.dart';

@immutable
sealed class RestClientException implements Exception {
  const RestClientException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  //
  final String message;
  final int? statusCode;
  final Object? cause;
}

final class StructuredBackendException extends RestClientException {
  /// The error returned by the backend

  const StructuredBackendException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() => 'StructuredBackendException('
      'message:, $message'
      'cause: $cause, '
      'statusCode: $statusCode, '
      ')';
}

final class DioExceptionHandler extends RestClientException {
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

final class UnauthenticatedException extends RestClientException {
  final String error;
  final int? statusCode;

  UnauthenticatedException({
    required this.error,
    this.statusCode,
  });

  @override
  String toString() => 'StructuredBackendException('
      'message: Unauthenticated, '
      'error: $error, '
      'statusCode: $statusCode, '
      ')';
}
