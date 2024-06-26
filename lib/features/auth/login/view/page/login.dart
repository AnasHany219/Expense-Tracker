import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:expense_tracker/features/auth/login/view/component/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(), // Creating LoginCubit instance
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
                    ParentCubit.instance.local["welcome_login"] ??
                        'Welcome Back',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  const LogInForm(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Navigate to ResetPassword page when tapped
                      Navigator.pushNamed(
                        context,
                        'reset_password',
                      );
                    },
                    child: Text(
                      ParentCubit.instance.local["forget_password"] ??
                          'Forget Password ? ', // Display forget password text
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        ParentCubit.instance.local["create_account"] ??
                            'Create New Account ? ', // Display create account text
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium, // Apply subTitle style
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          // Navigate to SignUpScreen page when tapped
                          Navigator.pushNamed(
                            context,
                            'signup',
                          );
                        },
                        child: Text(
                          ParentCubit.instance.local["welcome_signup"] ??
                              'Sign Up',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
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
