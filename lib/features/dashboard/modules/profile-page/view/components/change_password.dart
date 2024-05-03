// ignore_for_file: library_private_types_in_public_api

import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/controller/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatefulWidget {
  final String? email;

  const ChangePassword({super.key, this.email});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ProfileCubit controller = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter your new password:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8.0),
                buildPasswordFormField('New Password'),
                const SizedBox(height: 8.0),
                buildPasswordFormField('Confirm Password'),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    controller.updatePassword(context, widget.email!);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      primaryColor,
                    ),
                  ),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildPasswordFormField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: label == 'New Password'
            ? controller.newPassword
            : controller.confirmPassword,
        validator: label == 'New Password'
            ? Validator().passwordValidator
            : (val) => val != controller.newPassword.text
                ? 'Passwords do not match'
                : null,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          labelStyle: const TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }
}
