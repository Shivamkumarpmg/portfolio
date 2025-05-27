import 'package:flutter/foundation.dart';import 'dart:developer' as developer;

class CommonFunctions {
  static printLog(String msg) {
    if (kDebugMode) {
      developer.log(msg);
    }
  }
}