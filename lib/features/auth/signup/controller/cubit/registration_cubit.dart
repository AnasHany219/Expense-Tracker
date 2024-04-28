// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/features/auth/model/user.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
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
        try {
          // Insert the user data into the database
          await UserDB().insertUser(user);

          // Update user OTP in the database and send OTP to user's email
          await updateUserAndSendOTP(context, user);
        } catch (error) {
          debugPrint('Error during signup: $error');
          // Handle other errors related to signup process if needed
        }
      }
    } else {
      debugPrint('Invalid!');
    }
  }

  Future<void> updateUserAndSendOTP(BuildContext context, User user) async {
    // Create an instance of EmailSender
    EmailSender emailSender = EmailSender();
    String otp = emailSender.generateOTP();
    // Send OTP to the user's email
    await emailSender.sendOTP(user.email, otp);

    // Update user OTP in the database
    await UserDB().updateUserOTPByEmail(user.email, otp);
    // Navigate to the verification screen
    Navigator.pushNamed(
      context,
      'verification_screen',
      arguments: user.email,
    );
  }
}
