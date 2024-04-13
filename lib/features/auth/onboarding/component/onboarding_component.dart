import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';

class OnBoardingComponents extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnBoardingComponents(
      {super.key,
      required this.title,
      required this.description,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: titleText,
        ),
        const SizedBox(height: 10),
        Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: subTitle,
        ),
      ],
    );
  }
}
