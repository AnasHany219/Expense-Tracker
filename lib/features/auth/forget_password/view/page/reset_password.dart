import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:expense_tracker/features/auth/forget_password/view/component/reset_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => ForgetPasswordCubit(),
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}