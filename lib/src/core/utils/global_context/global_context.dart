import 'package:flutter/material.dart';

class GlobalContext {
  static GlobalContext? _instance;

  static GlobalContext get instance => _instance ??= GlobalContext._();

  GlobalContext._();

  final GlobalKey<ScaffoldMessengerState> globalContext =
      GlobalKey<ScaffoldMessengerState>();
}
