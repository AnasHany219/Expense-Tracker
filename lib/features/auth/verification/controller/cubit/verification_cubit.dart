// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/provider/user_db.dart';
import 'package:flutter/material.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  TextEditingController verificationControllers = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void verifyValidate(BuildContext context, String userEmail,
      {String? password}) async {
    if (formKey.currentState!.validate()) {
      final otp = verificationControllers.text;
      final userDB = UserDB();
      try {
        // Retrieve user from database by email
        final user = await userDB.getUserByEmail(userEmail);
        if (user != null && user.otpCode == otp) {
          // If OTP matches, set user's verified status to 1
          await userDB.updateUserVerificationStatus(userEmail, 1);

          if (password != null) {
            // If password is provided, update the password in the database
            await userDB.updateUserPasswordByEmail(userEmail, password);
          }

          // Navigate to the login screen
          Navigator.pushNamed(context, 'login');
        } else {
          // Show snackbar for wrong OTP code
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error, color: Colors.red), // Error icon
                  SizedBox(width: 8), // Space between icon and text
                  Text('Wrong OTP code'), // Error message
                ],
              ),
            ),
          );
        }
      } catch (e) {
        log('Error verifying OTP: $e');
        // Handle any errors
      }
    } else {
      log('Invalid OTP!');
    }
  }

  void resendOTP(BuildContext context, String email) async {
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

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP resent successfully'),
          ),
        );
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error resending OTP: $e');
      // Handle error
    }
  }

  void clear() {
    verificationControllers.clear();
  }
}
