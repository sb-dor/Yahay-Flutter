final class UnauthenticatedException implements Exception {
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
