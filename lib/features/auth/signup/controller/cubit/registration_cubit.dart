// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/model/user.dart';
import 'package:expense_tracker/provider/user_db.dart';
import 'package:flutter/material.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signUpValidate(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // Create a User object with the signup data
      User user = User(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the email already exists in the database
      bool emailExists = await UserDB().checkEmailExists(user.email);

      if (emailExists) {
        // Show a snackbar to inform the user that the email already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already exists'),
          ),
        );
      } else {
        // Insert the user data into the database
        try {
          await UserDB().insertUser(user);
          Navigator.pushNamed(context, 'verification_screen');
        } catch (error) {
          debugPrint('Error inserting user: $error');
          // Handle other errors related to database insertion if needed
        }
      }
    } else {
      debugPrint('Invalid!');
    }
  }
}
