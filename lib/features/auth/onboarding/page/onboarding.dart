// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/features/auth/onboarding/component/onboarding_buttons.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/features/auth/onboarding/component/onboarding_body.dart';
import 'package:expense_tracker/features/auth/signup/page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

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
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage(int index) {
    if (_currentPageIndex >= 0 &&
        _currentPageIndex < onboardingData.length - 1) {
      // Check if _currentPageIndex is valid and not the last page
      setState(() {
        _currentPageIndex = index; // Update _currentPageIndex
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (_currentPageIndex == onboardingData.length - 1) {
      // If it's the last page, perform the finish action
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  Future<void> _skipOnboarding(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('onboarding_completed', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _skipOnboard() {
    _skipOnboarding(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OnBoardingBody(
          onboardingData: onboardingData,
          pageController: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
        bottomNavigationBar: OnBoardingNavigationBar(
          onSkipPressed: _skipOnboard,
          onNextPressed: () {
            _nextPage(
                _currentPageIndex + 1); // Always try to move to the next page
          },
          isLastPage: _currentPageIndex == onboardingData.length - 1,
        ),
      ),
    );
  }
}
