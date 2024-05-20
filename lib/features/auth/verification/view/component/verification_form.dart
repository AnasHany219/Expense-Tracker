import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:expense_tracker/features/auth/verification/controller/cubit/verification_cubit.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/core/text_style.dart';

class VerificationForm extends StatefulWidget {
  final String? email;
  final String? password;

  const VerificationForm({super.key, required this.email, this.password});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  late VerificationCubit _controller;

  @override
  void initState() {
    super.initState();
    _controller = VerificationCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _controller,
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return buildForm();
        },
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          buildPinCodeTextField(),
          const SizedBox(height: 5),
          buildResendCodeText(),
        ],
      ),
    );
  }

  Widget buildPinCodeTextField() {
    return PinCodeTextField(
      controller: _controller.verificationControllers,
      appContext: context,
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      validator: Validator().otpValidator,
      onChanged: (value) {},
      onCompleted: (value) {
        _controller.verifyValidate(context, widget.email!,
            password: widget.password);
      },
      pinTheme: buildPinTheme(context),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
    );
  }

  PinTheme buildPinTheme(BuildContext context) {
    return PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      inactiveFillColor: Theme.of(context).buttonTheme.colorScheme!.background,
      inactiveColor: Theme.of(context).buttonTheme.colorScheme!.background,
      activeFillColor: Theme.of(context).buttonTheme.colorScheme!.background,
    );
  }

  Widget buildResendCodeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ParentCubit.instance.local["dont_receive_code"] ??
              'Don\'t receive any code ? ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            _controller.clear();
            _controller.resendOTP(context, widget.email!);
          },
          child: Text(
            ParentCubit.instance.local["resend_code"] ?? 'Resend',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
          ),
        ),
      ],
    );
  }
}
