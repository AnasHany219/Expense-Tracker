import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/verification/controller/cubit/verification_cubit.dart';
import 'package:expense_tracker/features/auth/verification/view/component/verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, String? email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationCubit>(
      create: (context) => VerificationCubit(),
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
