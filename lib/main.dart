// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/core/my_theme.dart';
import 'package:expense_tracker/features/auth/onboarding/view/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/page/profile_page.dart';
import 'package:expense_tracker/features/dashboard/view/page/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/core/route_generator.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if onboarding has been completed
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  // Determine initial route based on onboarding completion
  Widget initialRoute =
      onboardingCompleted ? const SignUpScreen() : const OnBoardingScreen();

  // Widget initialRoute = const DashboardPage(email: "kashkoushdevahmed@gmail.com");

  runApp(
    MainApp(
      initialRoute: initialRoute,
    ),
  );
}

class MainApp extends StatelessWidget {
  final Widget initialRoute;

  const MainApp({
    required this.initialRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.instance.light,
      darkTheme: MyTheme.instance.dark,
      themeMode: ThemeMode.light,
      home: initialRoute,
      onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
    );
  }
}
