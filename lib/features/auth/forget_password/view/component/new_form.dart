import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordForm extends StatefulWidget {
  final String? email;

  const NewPasswordForm({super.key, required this.email});

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  bool _isObscure = true;

  ForgetPasswordCubit controller = ForgetPasswordCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildInputForm('New Password'),
                buildInputForm('Confirm New Password'),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    controller.newPasswordValidation(context, widget.email!);
                  },
                  child: const PrimaryButton(buttonText: 'Verification'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildInputForm(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: label == 'New Password'
            ? controller.passwordController
            : controller.confirmPasswordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: label == 'New Password'
            ? Validator().passwordValidator
            : (value) => Validator().confirmPasswordValidator(
                  value,
                  controller.passwordController.text,
                ),
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.password_outlined),
          labelStyle: const TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
