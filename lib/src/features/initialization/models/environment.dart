import 'package:flutter/foundation.dart';

enum Environment {
  dev._('DEV'),
  prod._('PROD');

  final String value;

  const Environment._(this.value);

  static Environment from(String? value) => switch (value) {
    "DEV" => Environment.dev,
    "PROD" => Environment.prod,
    _ => kReleaseMode ? Environment.prod : Environment.dev,
  };
}
