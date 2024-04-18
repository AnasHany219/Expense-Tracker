// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/model/user.dart';
import 'package:expense_tracker/provider/user_db.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void logInValidate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      // Call function to check if email and password are valid
      checkCredentials(email, password, context);
    } else {
      log('Invalid!');
    }
  }

  Future<void> checkCredentials(
      String email, String password, BuildContext context) async {
    final userDB = UserDB();

    try {
      final user = await userDB.getUserByEmail(email);
      print(
          "email: ${user?.email}, pass: ${user?.password} verify: ${user?.verified}");
      // Check if email exists in the database
      if (user == null) {
        showSnackBar(context, 'Email not found');
        return;
      }

      // Retrieve user from database
      if (user.password != password) {
        showSnackBar(context, 'Incorrect password');
        return;
      }

      // Check if the user's account is verified
      if (user.verified == 0 || user.verified == null) {
        showSnackBar(context, 'Account not verified');
        await updateUserAndSendOTP(context, user);
        return;
      }

      // If email and password are valid, navigate to the next screen
      Navigator.pushNamed(context, 'dash_board');
    } catch (e) {
      log('Error checking credentials: $e');
      // Handle any errors
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.red), // Error icon
            const SizedBox(width: 8), // Space between icon and text
            Text(message), // Error message
          ],
        ),
      ),
    );
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
