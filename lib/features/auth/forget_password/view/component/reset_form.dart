import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/forget_password/controller/cubit/forget_password_cubit.dart';

class ResetForm extends StatefulWidget {
  const ResetForm({super.key});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
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
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: _forgetPasswordCubit.formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.bodySmall,
                    controller: _forgetPasswordCubit.emailController,
                    validator: Validator().emailValidator,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email',
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      _forgetPasswordCubit.resetPasswordValidation(context);
                    },
                    child: const PrimaryButton(buttonText: 'Reset Password'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
