import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/component/reset_form.dart';
import 'package:expense_tracker/features/auth/forget_password/page/new_password.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
              'Reset Password',
              style: titleText,
            ),
            const SizedBox(height: 5),
            Text(
              'Enter Your Email',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const ResetForm(),
            const SizedBox(height: 40),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewPassword(),
                    ),
                  );
                },
                child: const PrimaryButton(buttonText: 'Reset Password')),
          ],
        ),
      ),
    );
  }
}
