import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
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
                _buildTitle(context),
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
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Create New Account',
        style: Theme.of(context).textTheme.titleLarge,
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'login',
              );
            },
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
