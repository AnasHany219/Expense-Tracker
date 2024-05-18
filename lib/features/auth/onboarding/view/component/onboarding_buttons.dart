import 'package:flutter/material.dart';
import 'package:expense_tracker/core/text_style.dart';

class OnBoardingNavigationBar extends StatelessWidget {
  final VoidCallback onSkipPressed;
  final VoidCallback onNextPressed;
  final bool isLastPage;

  const OnBoardingNavigationBar({
    super.key,
    required this.onSkipPressed,
    required this.onNextPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: onSkipPressed,
            child: Text('Skip', style: Theme.of(context).textTheme.labelLarge),
          ),
          TextButton(
            onPressed: onNextPressed,
            child: Text(
              isLastPage ? 'Finish' : 'Next',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
