import 'package:expense_tracker/core/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/auth/verification/controller/cubit/verification_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationForm extends StatefulWidget {
  final String? email;
  final String? password;

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
                PinCodeTextField(
                  controller: controller.verificationControllers,
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  validator: Validator().otpValidator,
                  onChanged: (value) {},
                  onCompleted: (value) {
                    controller.verifyValidate(context, widget.email!,
                        password: widget.password);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: MediaQuery.of(context).size.width * 0.13,
                    fieldWidth: MediaQuery.of(context).size.width * 0.13,
                    inactiveFillColor: primaryColor,
                    inactiveColor: primaryColor,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        'Resend',
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
          );
        },
      ),
    );
  }
}
