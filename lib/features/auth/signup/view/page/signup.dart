import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/login/view/page/login.dart';
import 'package:expense_tracker/features/auth/signup/controller/cubit/registration_cubit.dart';
import 'package:expense_tracker/features/auth/signup/view/component/signup_form.dart';

/// The screen for user sign up.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => RegistrationCubit(),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SignUpForm(),
                ),
                _buildLoginRow(context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the title widget.
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Create New Account',
        style: titleText,
      ),
    );
  }

  /// Builds the login row widget.
  Widget _buildLoginRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            'Have an account? ',
            style: subTitle,
          ),
          const SizedBox(width: 5),
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
              'Login',
              style: textButton.copyWith(
                decoration: TextDecoration.underline,
                decorationThickness: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
