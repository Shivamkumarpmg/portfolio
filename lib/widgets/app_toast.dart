import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';

export 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static final String _failMessage = "Server not responding. Please try again later";
  static final String _successMessage = "success";

  static void showSuccess(String? message,
      {Toast toastLength = Toast.LENGTH_LONG}) {
    Fluttertoast.showToast(
        msg: message ?? _successMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConst.themeColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showError(String? message,
      {Toast toastLength = Toast.LENGTH_LONG}) {
    Fluttertoast.showToast(
        msg: message ?? _failMessage,
        toastLength: toastLength,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);
  }
}
