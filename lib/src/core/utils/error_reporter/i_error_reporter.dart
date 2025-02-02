abstract interface class IErrorReporter {
  Future<void> report();
}

final class NoOpIErrorReporter implements IErrorReporter {
  @override
  Future<void> report() async {
    // No implementation inside
  }
}


