import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/page/reset_password.dart';
import 'package:expense_tracker/features/auth/login/component/login_form.dart';
import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/features/auth/signup/page/signup.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScrean extends StatelessWidget {
  const LoginScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Text(
              'Welcome Back',
              style: titleText,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            const LogInForm(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPassword(),
                  ),
                );
              },
              child: const Text(
                'Forget Password ? ',
                style: TextStyle(
                  color: shadowGray,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const PrimaryButton(
              buttonText: 'Login',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Create New Account ? ',
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
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: textButton.copyWith(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
