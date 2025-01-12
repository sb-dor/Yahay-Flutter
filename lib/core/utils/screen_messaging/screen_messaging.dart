import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenMessaging {
  static ScreenMessaging? _instance;

  static ScreenMessaging get instance => _instance ??= ScreenMessaging._();

  ScreenMessaging._();

  void toast(
    String message, {
    bool error = false,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: error ? Colors.red : null,
      textColor: textColor,
    );
  }
}
