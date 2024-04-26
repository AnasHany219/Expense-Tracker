// ignore_for_file: deprecated_member_use

import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker/features/auth/onboarding/view/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:expense_tracker/features/auth/verification/view/page/verification.dart';
import 'package:expense_tracker/features/dashboard/view/page/dashboard_page.dart';
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
  // Widget initialRoute =
  //     onboardingCompleted ? const SignUpScreen() : const OnBoardingScreen();

  // For testing Purposes
  // Widget initialRoute= const VerificationScreen(email: "test", password: "2222");
  Widget initialRoute = const DashboardPage();

  MaterialApp materialApp = MaterialApp(
    builder: DevicePreview.appBuilder,
    useInheritedMediaQuery: true,
    home: initialRoute,
    onGenerateRoute: MyRoutes.onGenerateRoute,
  );

  runApp(DevicePreview(
    enabled: true,
    builder: (context) => materialApp,
  ));
}

class MyRoutes {
  static List<Route> initialRoutes = [
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const DashboardPage(),
    )
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        final List data = settings.arguments as List;
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => DashboardPage());
      case 'signup':
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SignUpScreen());
      default:
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => OnBoardingScreen());
    }
  }
}
