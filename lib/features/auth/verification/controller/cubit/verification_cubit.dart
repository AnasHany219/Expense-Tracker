// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/provider/user_db.dart';
import 'package:flutter/material.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  TextEditingController verificationControllers = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void verifyValidate(BuildContext context, String userEmail) async {
    if (formKey.currentState!.validate()) {
      final otp = verificationControllers.text;
      final userDB = UserDB();
      try {
        // Retrieve user from database by email
        final user = await userDB.getUserByEmail(userEmail);
        if (user != null && user.otpCode == otp) {
          // If OTP matches, set user's verified status to 1
          await userDB.updateUserVerificationStatus(userEmail, 1);
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

  void clear() {
    verificationControllers.clear();
  }
}
