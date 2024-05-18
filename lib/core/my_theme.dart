import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class MyTheme {
  static final MyTheme instance = MyTheme();
  ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.light(background: primaryColor),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, color: primaryColor),
          titleMedium: TextStyle(
              fontSize: 18, color: secondaryColor, fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontSize: 18, color: primaryColor)));

  ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.black,
      buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(background: primaryColor2),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, color: primaryColor2),
          titleMedium: TextStyle(
              fontSize: 18,
              color: secondaryColor2,
              fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontSize: 18, color: primaryColor2)));
}
