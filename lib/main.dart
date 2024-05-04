import 'package:flutter/material.dart';
import 'package:yahay/injections/injections.dart';

void main() async {
  await Injections.init();

  runApp(const Yahay());
}

class Yahay extends StatelessWidget {
  const Yahay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
