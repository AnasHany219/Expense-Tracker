import 'package:expense_tracker/features/auth/forget_password/view/page/new_password.dart';
import 'package:expense_tracker/features/auth/forget_password/view/page/reset_password.dart';
import 'package:expense_tracker/features/auth/login/view/page/login.dart';
import 'package:expense_tracker/features/auth/onboarding/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:expense_tracker/features/auth/verification/page/verification.dart';
import 'package:flutter/material.dart';

class InitialRouteGenerator {
  static List<Route> initialRoute = [
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const OnBoardingScreen(),
    ),
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const SignUpScreen(),
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'singup':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SignUpScreen(),
        );
      case 'login':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case 'reset_password':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const ResetPassword(),
        );
      case 'verification_screen':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const VerificationScreen(),
        );
      case 'new_password':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const NewPassword(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const OnBoardingScreen(),
        );
    }
  }
}
