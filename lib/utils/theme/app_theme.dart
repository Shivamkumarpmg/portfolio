
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    highlightColor: ColorConst.themeColor,
    useMaterial3: true,
    fontFamily: AppFonts.themeFont,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConst.themeColor),
    textTheme: TextTheme(),
    splashColor: ColorConst.themeColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorConst.themeColor,
      selectionColor: ColorConst.themeColor,
      selectionHandleColor: ColorConst.themeColor
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorConst.themeColor,
      focusColor: ColorConst.themeColor,
      hoverColor: ColorConst.themeColor,

    ),
  );
  static ThemeData get darkTheme => ThemeData.dark();
}
