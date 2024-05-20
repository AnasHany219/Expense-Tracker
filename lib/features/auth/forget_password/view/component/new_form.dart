import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/forget_password/controller/cubit/forget_password_cubit.dart';

class NewPasswordForm extends StatefulWidget {
  final String? email;

  const NewPasswordForm({super.key, required this.email});

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  bool _isObscure = true;

  late ForgetPasswordCubit _forgetPasswordCubit;

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = ForgetPasswordCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _forgetPasswordCubit,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return Form(
            key: _forgetPasswordCubit.formKey,
            child: Column(
              children: [
                _buildInputForm(context, 'New Password',
                    _forgetPasswordCubit.passwordController),
                _buildInputForm(context, 'Confirm New Password',
                    _forgetPasswordCubit.confirmPasswordController),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    _forgetPasswordCubit.newPasswordValidation(
                        context, widget.email!);
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

  Padding _buildInputForm(
      BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: controller,
        validator: label == 'New Password'
            ? Validator().passwordValidator
            : (value) => Validator().confirmPasswordValidator(
                  value,
                  _forgetPasswordCubit.passwordController.text,
                ),
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.password_outlined),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).buttonTheme.colorScheme!.background),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).buttonTheme.colorScheme!.background,
            ),
          ),
        ),
      ),
    );
  }
}
