import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/view/page/reset_password.dart';
import 'package:expense_tracker/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:expense_tracker/features/auth/login/view/component/login_form.dart';
import 'package:expense_tracker/features/auth/signup/view/page/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        color: textShadow,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
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
        },
      ),
    );
  }
}
