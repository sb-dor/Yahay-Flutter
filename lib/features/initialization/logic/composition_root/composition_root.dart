import 'package:yahay/features/initialization/models/dependency_container.dart';

final class CompositionRoot extends AsyncFactory<CompositionResult> {
  @override
  Future<CompositionResult> create() async {
    final dependencyContainer = await DependencyContainerFactory().create();

    return CompositionResult(dependencyContainer);
  }
}

class CompositionResult {
  final DependencyContainer dependencies;

  CompositionResult(this.dependencies);
}

final class DependencyContainerFactory extends AsyncFactory<DependencyContainer> {
  @override
  Future<DependencyContainer> create() {
    // TODO: implement create
    throw UnimplementedError();
  }
}

abstract base class Factory<T> {
  T create();
}

abstract base class AsyncFactory<T> {
  Future<T> create();
}
