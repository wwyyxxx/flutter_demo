import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WyxToast {
  static void showTip(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
