import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/verification/controller/cubit/verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationForm extends StatefulWidget {
  final String? email;

  final String? password; // Add password parameter

  const VerificationForm({super.key, required this.email, this.password});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  VerificationCubit controller = VerificationCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.verificationControllers,
                  validator: Validator().otpValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlign: TextAlign.center,
                  maxLength: 4, // Set the maximum length to 4
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: "", // Hide the character counter
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    controller.verifyValidate(context, widget.email!,
                        password: widget.password);
                  },
                  child: const PrimaryButton(buttonText: 'Check!'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        'Don\'t receive any code ? ',
                        style: subTitle,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.clear();
                          controller.resendOTP(context, widget.email!);
                        },
                        child: Text(
                          'Resent',
                          style: textButton.copyWith(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
