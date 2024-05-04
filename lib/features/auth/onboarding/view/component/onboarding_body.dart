import 'package:flutter/material.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_component.dart';

/// Widget representing the body of the onboarding screen.
class OnBoardingBody extends StatelessWidget {
  final List<Map<String, String>> onboardingData;
  final PageController pageController;
  final Function(int) onPageChanged; // Callback function

  const OnBoardingBody({
    Key? key,
    required this.onboardingData,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: onPageChanged, // Call the callback function
            itemBuilder: (BuildContext context, int index) {
              return OnBoardingComponent(
                title: onboardingData[index]['title']!,
                description: onboardingData[index]['description']!,
                imagePath: onboardingData[index]['imagePath']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
