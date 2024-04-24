import 'package:flutter/material.dart';
import 'package:expense_tracker/features/auth/onboarding/view/component/onboarding_component.dart';

class OnBoardingBody extends StatelessWidget {
  final List<Map<String, String>> onboardingData;
  final PageController pageCntrl;
  final Function(int) onPageChanged; // Callback function

  const OnBoardingBody({
    super.key,
    required this.onboardingData,
    required this.pageCntrl,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Expanded(
          child: PageView.builder(
            controller: pageCntrl,
            itemCount: onboardingData.length,
            onPageChanged: onPageChanged, // Call the callback function
            itemBuilder: (BuildContext context, int index) {
              return OnBoardingComponents(
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