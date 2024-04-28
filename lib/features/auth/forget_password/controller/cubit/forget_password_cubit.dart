// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:flutter/material.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> resetPasswordValidation(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      bool emailExists = await UserDB().checkEmailExists(email);

      if (!emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email does not exist'),
          ),
        );
      } else {
        Navigator.pushNamed(
          context,
          'new_password',
          arguments: email,
        );
      }
    } else {
      log('Invalid!');
    }
  }

  Future<void> newPasswordValidation(BuildContext context, String email) async {
    if (formKey.currentState!.validate()) {
      String password = passwordController.text;

      await updateUserAndSendOTP(context, email, password);
    } else {
      log('Invalid!');
    }
  }

  Future<void> updateUserAndSendOTP(
      BuildContext context, String email, String password) async {
    try {
      final userDB = UserDB();
      final user = await userDB.getUserByEmail(email);

      if (user != null) {
        // Create an instance of EmailSender
        EmailSender emailSender = EmailSender();

        String otp = emailSender.generateOTP();
        // Send OTP to the user's email

        await emailSender.sendOTP(user.email, otp);

        // Update user OTP in the database
        await userDB.updateUserOTPByEmail(user.email, otp);

        // Navigate to the verification screen
        Navigator.pushNamed(
          context,
          'verification_screen',
          arguments: {'email': email, 'password': password},
        );
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error updating user and sending OTP: $e');
      // Handle error
    }
  }
}
