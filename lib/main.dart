// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/core/my_theme.dart';
import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:expense_tracker/features/auth/onboarding/view/page/onboarding.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:expense_tracker/features/auth/verification/view/page/verification.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/page/profile_page.dart';
import 'package:expense_tracker/features/dashboard/view/page/dashboard_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Widget initialRoute =
  //     const DashboardPage(email: "kashkoushdevahmed@gmail.com");

  // Widget initialRoute = const VerificationScreen(email:"kashkoushdevahmed@gmail.com",password:"ah123532003");

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
    return BlocProvider<ParentCubit>(
        create: (context) => ParentCubit.instance,
        child: BlocBuilder<ParentCubit, ParentState>(
          builder: (context, state) {
            return MaterialApp(
              theme: MyTheme.instance.light,
              darkTheme: MyTheme.instance.dark,
              themeMode: ParentCubit.instance.themeMode,
              home: initialRoute,
              onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
            );
          },
        ));
  }
}
/* 
ahmed
kashkoush
kashkoushdevahmed@gmail.com
ah123532003
 */
