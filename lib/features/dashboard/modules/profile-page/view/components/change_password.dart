// ignore_for_file: library_private_types_in_public_api

import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
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
            child: BlocProvider<ParentCubit>(
              create: (context) => ParentCubit.instance,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ParentCubit.instance.local["enter_new_password"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  buildPasswordFormField(
                      label: ParentCubit.instance.local["new_password"],
                      isNewPassword: 1),
                  const SizedBox(height: 8.0),
                  buildPasswordFormField(
                      label: ParentCubit.instance.local["confirm_password"],
                      isNewPassword: 0),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      controller.updatePassword(context, widget.email!);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).buttonTheme.colorScheme!.background,
                      ),
                    ),
                    child: Text(
                      ParentCubit.instance.local["change_password"],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildPasswordFormField({String label = "", int isNewPassword = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: isNewPassword == 1
            ? controller.newPassword
            : controller.confirmPassword,
        validator: isNewPassword == 1
            ? Validator().passwordValidator
            : (val) => val != controller.newPassword.text
                ? 'Passwords do not match'
                : null,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).buttonTheme.colorScheme!.background),
          ),
        ),
      ),
    );
  }
}
