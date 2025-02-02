import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'i_error_reporter.dart';

final class FirebaseErrorReporter implements IErrorReporter {
  //
  FirebaseErrorReporter({
    required this.exception,
    required this.stackTrace,
    required this.firebaseCrashlytics,
  });

  final Object exception;
  final StackTrace stackTrace;
  final FirebaseCrashlytics firebaseCrashlytics;

  @override
  Future<void> report() async => await firebaseCrashlytics.recordError(
        exception,
        stackTrace,
        fatal: true,
      );
}
