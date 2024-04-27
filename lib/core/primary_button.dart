import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const PrimaryButton({
    Key? key, 
    required this.buttonText, 
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        child: Text(
          buttonText,
          style: textButton.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

