import 'package:expense_tracker/features/auth/onboarding/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/core/route_generator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Load environment variables
  await dotenv.load();

  // Check if onboarding has been completed
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  // Determine initial route based on onboarding completion
  Widget initialRoute =
      onboardingCompleted ? const SignUpScreen() : const OnBoardingScreen();

  MaterialApp materialApp = MaterialApp(
    home: initialRoute,
    onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
  );

  runApp(materialApp);
}
