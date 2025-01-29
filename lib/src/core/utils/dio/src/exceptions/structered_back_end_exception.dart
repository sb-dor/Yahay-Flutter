final class StructuredBackendException {
  /// The error returned by the backend
  final Map<String, Object?> error;
  final int? statusCode;

  const StructuredBackendException({
    required this.error,
    this.statusCode,
  });

  @override
  String toString() => 'StructuredBackendException('
      'message: Backend returned structured error, '
      'error: $error, '
      'statusCode: $statusCode, '
      ')';
}
