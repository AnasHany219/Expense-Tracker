// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_buttons.dart';

/// Controller for the onboarding process.
class OnBoardingController extends StatefulWidget {
  const OnBoardingController({super.key});

  @override
  _OnBoardingControllerState createState() => _OnBoardingControllerState();
}

/// State class for OnBoardingController.
class _OnBoardingControllerState extends State<OnBoardingController> {
  late PageController pageController;
  int currentPageIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to Expense Tracker!',
      'description':
          'Start tracking your expenses easily and efficiently with our intuitive app.',
      'imagePath': 'assets/images/expense_tracker_image.png',
    },
    {
      'title': 'Visualize Your Spending',
      'description':
          'Gain insights into your spending patterns with easy-to-understand charts and graphs.',
      'imagePath': 'assets/images/dashboard_screenshot.png',
    },
    {
      'title': 'Set Your Budget',
      'description':
          'Set up your monthly budget and stay on top of your financial goals.',
      'imagePath': 'assets/images/wallet.png',
    },
    {
      'title': 'Stay Organized',
      'description':
          'Categorize your expenses and stay organized with our user-friendly interface.',
      'imagePath': 'assets/images/person_with_app.png',
    },
    // Add more onboarding data as needed
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OnBoardingBody(
          onboardingData: onboardingData,
          pageController: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        bottomNavigationBar: OnBoardingNavigationBar(
          onSkipPressed: () {
            saveOnboardingCompletion();
            skipOnboarding();
          },
          onNextPressed: () {
            saveOnboardingCompletion();
            nextPage(currentPageIndex + 1);
          },
          isLastPage: currentPageIndex == onboardingData.length - 1,
        ),
      ),
    );
  }

  /// Navigates to the next onboarding page.
  void nextPage(int index) {
    if (currentPageIndex >= 0 && currentPageIndex < onboardingData.length - 1) {
      setState(() {
        currentPageIndex = index;
      });
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (currentPageIndex == onboardingData.length - 1) {
      Navigator.pushNamed(
        context,
        'signup',
      );
    }
  }

  /// Skips the onboarding process.
  void skipOnboarding() {
    Navigator.pushReplacementNamed(
      context,
      'signup',
    );
  }

  /// Saves the completion state of onboarding to shared preferences.
  Future<void> saveOnboardingCompletion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('onboarding_completed', true);
  }
}
