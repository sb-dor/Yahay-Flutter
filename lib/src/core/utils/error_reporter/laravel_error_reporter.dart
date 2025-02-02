import 'i_error_reporter.dart';

final class LaravelErrorReporter implements IErrorReporter {
  //
  LaravelErrorReporter({
    required this.exception,
    required this.stackTrace,
  });

  final Object exception;
  final StackTrace stackTrace;

  @override
  Future<void> report() async {
    //
  }
}
