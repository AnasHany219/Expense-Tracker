import 'package:expense_tracker/features/auth/onboarding/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Check if onboarding has been completed
  bool onBoardingCompleted =
      sharedPreferences.getBool('onboarding_completed') ?? false;

  // If onboarding has not been completed, show OnBoardingScreen, otherwise show SignUpScreen
  runApp(MaterialApp(
    home: onBoardingCompleted ? const SignUpScreen() : const OnBoardingScreen(),
  ));
}
