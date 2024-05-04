import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenMessaging {
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
