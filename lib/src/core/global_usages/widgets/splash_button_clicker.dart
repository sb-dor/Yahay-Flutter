import 'package:flutter/material.dart';

class SplashButtonClicker extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? splashColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const SplashButtonClicker({
    super.key,
    required this.child,
    required this.onTap,
    this.splashColor,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: InkWell(
        splashColor: splashColor ?? Colors.blueAccent.shade100,
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        child: child,
      ),
    );
  }
}
