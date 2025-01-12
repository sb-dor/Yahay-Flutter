import 'package:flutter/material.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/initialization/widgets/material_context.dart';

class RootContext extends StatelessWidget {
  final CompositionResult compositionResult;

  const RootContext({
    super.key,
    required this.compositionResult,
  });

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: compositionResult.dependencies,
      child: const MaterialContext(),
    );
  }
}
