import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:flutter/material.dart';

class ResetForm extends StatelessWidget {
  const ResetForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: Validator().emailValidator,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: 'Email',
          hintStyle: TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
