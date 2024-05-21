import 'package:flutter/material.dart';

const primaryColor = Color(0xff003366);
const primaryColor2 = Color(0xff66b3ff);
const secondaryColor = Color(0xff4d7298);
const secondaryColor2 = Color(0xff99ccff);
const textFieldColor = Color(0xff336699);
const textFieldColor2 = Color(0xffb0bec5);
const textShadow = Color(0xff000000);

// const primaryColor = Color(0xff004d99);
// const primaryColor2 = Color(0xff66a3ff);
// const secondaryColor = Color(0xff006699);
// const secondaryColor2 = Color(0xff66ccff);
// const textFieldColor = Color(0xff336699);
// const textFieldColor2 = Color(0xff99ccff);
// const textShadow = Color(0xff000000);

class MyTheme {
  static final MyTheme instance = MyTheme();

  ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      colorScheme:
          ColorScheme.light(background: primaryColor, primary: primaryColor),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24, color: primaryColor, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          fontSize: 16, color: primaryColor, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontSize: 18, color: secondaryColor, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 16, color: textFieldColor),
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
      titleLarge: TextStyle(
          fontSize: 24, color: primaryColor2, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontSize: 18, color: secondaryColor2, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          fontSize: 18, color: primaryColor2, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          fontSize: 16, color: primaryColor2, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 16, color: textFieldColor2),
      bodyMedium: TextStyle(
          fontSize: 14, color: primaryColor2, fontWeight: FontWeight.w700),
    ),
  );
}
