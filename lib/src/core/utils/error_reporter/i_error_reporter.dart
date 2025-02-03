abstract interface class IErrorReporter {
  Future<void> report();
}

final class NoOpErrorReporter implements IErrorReporter {
  @override
  Future<void> report() async {
    // No implementation inside
  }
}


