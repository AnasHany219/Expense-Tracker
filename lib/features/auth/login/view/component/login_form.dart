import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/login/controller/cubit/login_cubit.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = LoginCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginCubit,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Form(
            key: _loginCubit.formKey,
            child: Column(
              children: [
                buildInputForm('Email', false),
                buildInputForm('Password', true),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      _loginCubit.logInValidate(context);
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

  Padding buildInputForm(String label, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: isPassword
            ? _loginCubit.passwordController
            : _loginCubit.emailController,
        validator: isPassword
            ? Validator().passwordValidator
            : Validator().emailValidator,
        obscureText: isPassword ? _isObscure : false,
        decoration: InputDecoration(
          labelText: ParentCubit.instance.local[label] ?? label,
          prefixIcon: isPassword
              ? const Icon(Icons.password_outlined)
              : const Icon(Icons.email),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).buttonTheme.colorScheme!.background),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.background,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
