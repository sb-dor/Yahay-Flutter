import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
    required this.error,
    super.statusCode,
    super.cause,
  }) : super(message: 'Backend returned structured error');

  final Map<String, Object?> error;

  @override
  String toString() =>
      'StructuredBackendException('
      'message:, $message'
      'cause: $cause, '
      'statusCode: $statusCode, '
      ')';
}

final class ClientException extends RestClientException {
  const ClientException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() =>
      'ClientException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

final class UnauthenticatedException extends RestClientException {
  const UnauthenticatedException({
    required DioException exception,
    super.statusCode,
    super.cause,
  }) : _dioException = exception,
       super(message: "User is Unauthenticated");

  final DioException _dioException;

  @override
  String toString() =>
      'StructuredBackendException('
      'message: $message | SERVER_ERROR: ${_dioException.response?.data}'
      ' | ERROR: ${_dioException.error}, '
      'cause: $cause, '
      'statusCode: $statusCode, '
      ')';
}

final class DioExceptionHandler {
  //
  const DioExceptionHandler({
    required DioException dioException,
    required this.serverError,
  }) : _dioException = dioException;

  final DioException _dioException;
  final String serverError;

  @override
  String toString() {
    return "DioExceptionHandler: ${_dioException.message}: SERVER_ERROR: $serverError"
        " | MESSAGE: ${_dioException.message} | ERROR: ${_dioException.error}"
        " | STATUS_MESSAGE: ${_dioException.response?.statusMessage}"
        " | STATUS_CODE: ${_dioException.response?.statusCode}"
        " | STACKTRACE: ${_dioException.stackTrace}"
        " | DIO_EXCEPTION_TYPE: ${_dioException.type}"
        " | REAL_URI: ${_dioException.response?.realUri}";
  }
}
