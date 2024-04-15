import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/signup/controller/cubit/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;

  RegistrationCubit controller = RegistrationCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildInputForm('First Name'),
                buildInputForm('Last Name'),
                buildInputForm('Email'),
                buildInputForm('Password'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      controller.signUpValidate();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const VerificationScreen(),
                      //   ),
                      // );
                    },
                    child: const PrimaryButton(buttonText: 'Verification'),
                  ),
                ),
                const SizedBox(
                  height: 5,
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
        controller: label == 'First Name'
            ? controller.firstNameController
            : label == 'Last Name'
                ? controller.lastNameController
                : label == 'Email'
                    ? controller.emailController
                    : label == 'Password'
                        ? controller.passwordController
                        : null,
        obscureText: label == 'Password' ? _isObscure : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: label == 'First Name'
            ? Validator().nameValidator
            : label == 'Last Name'
                ? Validator().nameValidator
                : label == 'Password'
                    ? Validator().passwordValidator
                    : label == 'Email'
                        ? Validator().emailValidator
                        : null,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: label == 'Password'
              ? const Icon(Icons.password_outlined)
              : label == 'Email'
                  ? const Icon(Icons.email)
                  : null,
          hintStyle: const TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          suffixIcon: label == 'Password'
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
