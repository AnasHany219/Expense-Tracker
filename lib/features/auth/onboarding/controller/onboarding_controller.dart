import 'package:flutter/material.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_body.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_buttons.dart';

class OnBoardingController extends StatefulWidget {
  const OnBoardingController({super.key});

  @override
  _OnBoardingControllerState createState() => _OnBoardingControllerState();
}

class _OnBoardingControllerState extends State<OnBoardingController> {
  late PageController pageCntrl;
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
    pageCntrl = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OnBoardingBody(
          onboardingData: onboardingData,
          pageCntrl: pageCntrl,
          onPageChanged: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        bottomNavigationBar: OnBoardingNavigationBar(
          onSkipPressed: skipOnboarding,
          onNextPressed: () {
            sharedPreferences();
            nextPage(currentPageIndex + 1);
          },
          isLastPage: currentPageIndex == onboardingData.length - 1,
        ),
      ),
    );
  }

  void nextPage(int index) {
    if (currentPageIndex >= 0 && currentPageIndex < onboardingData.length - 1) {
      setState(() {
        currentPageIndex = index;
      });
      pageCntrl.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (currentPageIndex == onboardingData.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  void skipOnboarding() {
    sharedPreferences();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}

Future<void> sharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('onboarding_completed', true);
}
