import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;

  LoginCubit controller = LoginCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildInputForm('Email', false),
                buildInputForm('Password', true),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      controller.logInValidate(context);
                    },
                    child: const PrimaryButton(buttonText: 'Login'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: pass
            ? controller.emailController
            : label == 'Password'
                ? controller.passwordController
                : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:
            pass ? Validator().passwordValidator : Validator().emailValidator,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: pass
              ? const Icon(Icons.password_outlined)
              : const Icon(Icons.email),
          labelStyle: const TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
