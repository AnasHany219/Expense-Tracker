import 'package:expense_tracker/features/expense/add_expense/view/page/add_expense_page.dart';
import 'package:expense_tracker/features/auth/forget_password/view/page/new_password.dart';
import 'package:expense_tracker/features/auth/forget_password/view/page/reset_password.dart';
import 'package:expense_tracker/features/auth/login/view/page/login.dart';
import 'package:expense_tracker/features/auth/onboarding/view/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:expense_tracker/features/auth/verification/view/page/verification.dart';
import 'package:expense_tracker/features/dashboard/view/page/dashboard_page.dart';
import 'package:expense_tracker/features/expense/view_expense/view/page/view_expense_page.dart';
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
        final dynamic arguments = settings.arguments;
        if (arguments is String) {
          // Only email is provided
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                VerificationScreen(email: arguments),
          );
        } else if (arguments is Map<String, String>) {
          // Both email and password are provided
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => VerificationScreen(
                email: arguments['email'], password: arguments['password']),
          );
        } else {
          throw ArgumentError(
              'Invalid arguments for verification_screen: $arguments');
        }
      case 'new_password':
        final String? email = settings.arguments as String?;
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => NewPassword(email: email),
        );
      case 'dash_board':
        final String? email = settings.arguments as String?;
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DashboardPage(email: email),
        );
      case 'add_expense':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const AddExpensePage(),
        );
      case 'view_expense':
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const ViewExpensePage(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const OnBoardingScreen(),
        );
    }
  }
}
