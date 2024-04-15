import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/view/component/new_form.dart';
import 'package:expense_tracker/features/auth/verification/page/verification.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            Text(
              'New Password',
              style: titleText,
            ),
            const SizedBox(height: 5),
            Text(
              'Enter Your New Password',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const NewPasswordForm(),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerificationScreen(),
                  ),
                );
              },
              child: const PrimaryButton(buttonText: 'Verification'),
            ),
          ],
        ),
      ),
    );
  }
}
