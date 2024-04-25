import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:expense_tracker/features/auth/forget_password/view/component/new_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPassword extends StatelessWidget {
  final String? email;
  const NewPassword({super.key, this.email});

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  NewPasswordForm(email: email),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
