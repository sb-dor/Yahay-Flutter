import 'package:flutter/material.dart';
import 'package:yahay/features/initialization/models/dependency_container.dart';

class DependenciesScope extends InheritedWidget {
  //
  const DependenciesScope({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final DependencyContainer dependencies;

  static DependencyContainer? of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final DependenciesScope? result =
          context.dependOnInheritedWidgetOfExactType<DependenciesScope>();
      assert(result != null, 'No _InheritedScope found in context');
      return result?.dependencies;
    } else {
      final result = context.getElementForInheritedWidgetOfExactType<DependenciesScope>()?.widget;
      return result is DependenciesScope ? result.dependencies : null;
    }
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => !identical(
        dependencies,
        oldWidget.dependencies,
      );
}
