import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'i_error_reporter.dart';

final class FirebaseErrorReporter implements IErrorReporter {
  //
  FirebaseErrorReporter({
    required this.exception,
    required this.stackTrace,
  });

  final Object exception;
  final StackTrace stackTrace;

  @override
  Future<void> report() async => FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
      );
}
