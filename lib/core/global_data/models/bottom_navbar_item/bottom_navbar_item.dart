import 'package:flutter/material.dart';

@immutable
class BottomNavbarItem {
  final Widget screen;
  final Widget icon;
  final String label;

  const BottomNavbarItem({
    required this.screen,
    required this.icon,
    required this.label,
  });
}
