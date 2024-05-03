// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/features/auth/signup/model/database_repo/user_db.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Validates the email for password reset and navigates to the appropriate screen.
  Future<void> resetPasswordValidation(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final String email = emailController.text;
      final bool emailExists = await UserDB().checkEmailExists(email);

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

  /// Validates the new password and sends OTP for verification.
  Future<void> newPasswordValidation(BuildContext context, String email) async {
    if (formKey.currentState!.validate()) {
      final String password = passwordController.text;
      await updateUserAndSendOTP(context, email, password);
    } else {
      log('Invalid!');
    }
  }

  /// Updates user's OTP and sends OTP to the user's email.
  Future<void> updateUserAndSendOTP(
      BuildContext context, String email, String password) async {
    try {
      final userDB = UserDB();
      final user = await userDB.getUserByEmail(email);

      if (user != null) {
        final EmailSender emailSender = EmailSender();
        final String otp = emailSender.generateOTP();

        await emailSender.sendOTP(user.email, otp);
        await userDB.updateUserOTPByEmail(user.email, otp);

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
