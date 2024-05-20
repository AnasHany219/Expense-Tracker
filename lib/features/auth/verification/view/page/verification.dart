import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/auth/verification/controller/cubit/verification_cubit.dart';
import 'package:expense_tracker/features/auth/verification/view/component/verification_form.dart';

/// Screen for entering verification code.
class VerificationScreen extends StatelessWidget {
  final String? email;
  final String? password;

  /// Constructor for VerificationScreen.
  const VerificationScreen({super.key, required this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationCubit>(
      create: (context) => VerificationCubit(),
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  /// Builds the body of the verification screen.
  Widget _buildBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: BlocProvider<ParentCubit>(
          create: (context) => ParentCubit.instance,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  ParentCubit.instance.local["verification_code"] ??
                      'Verification Code',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 5),
              Text(
                  ParentCubit.instance.local['enter_otp'] ??
                      'Enter The OTP Code',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              VerificationForm(email: email, password: password),
            ],
          ),
        ));
  }
}
