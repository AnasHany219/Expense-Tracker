import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('First Name'),
        buildInputForm('Last Name'),
        buildInputForm('Email'),
        buildInputForm('Password'),
      ],
    );
  }

  Padding buildInputForm(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: label == 'Password' ? _isObscure : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: label == 'Password'
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
