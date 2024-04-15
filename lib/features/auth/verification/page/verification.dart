import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/login/page/login.dart';
import 'package:expense_tracker/features/auth/verification/component/verification_form.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Text(
              'Verification Code',
              style: titleText,
            ),
            const SizedBox(height: 5),
            Text(
              'Enter The OTP Code',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            const VerificationForm(),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const PrimaryButton(buttonText: 'Ok'),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Don\'t receive any code ? ',
                    style: subTitle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Resent',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
