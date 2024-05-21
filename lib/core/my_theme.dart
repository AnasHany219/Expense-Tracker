import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final MyTheme instance = MyTheme();

  ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      colorScheme:
          ColorScheme.light(background: primaryColor, primary: primaryColor),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 24, color: primaryColor),
      bodySmall: TextStyle(fontSize: 18, color: textFieldColor),
      labelLarge: TextStyle(fontSize: 18, color: primaryColor),
      titleMedium: TextStyle(
          fontSize: 18, color: secondaryColor, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 18, color: textFieldColor),
      bodyMedium: TextStyle(
          fontSize: 14, color: primaryColor, fontWeight: FontWeight.w700),
    ),
  );

  ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: const Color(0xff121212),
    buttonTheme: const ButtonThemeData(
      colorScheme:
          ColorScheme.dark(background: primaryColor2, primary: primaryColor2),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 24, color: primaryColor2),
      titleMedium: TextStyle(
          fontSize: 18, color: secondaryColor2, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontSize: 18, color: primaryColor2),
      bodySmall: TextStyle(fontSize: 14, color: textFieldColor2),
      titleSmall: TextStyle(fontSize: 18, color: textFieldColor2),
      bodyMedium: TextStyle(
          fontSize: 14, color: primaryColor2, fontWeight: FontWeight.w700),
    ),
  );
}
