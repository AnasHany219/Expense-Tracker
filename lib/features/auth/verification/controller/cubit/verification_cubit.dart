// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/features/auth/signup/model/database_repo/user_db.dart';
import 'package:expense_tracker/features/auth/signup/model/user.dart';
import 'package:flutter/material.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  // Text controller for verification code input field
  TextEditingController verificationControllers = TextEditingController();

  // Form key for form validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Validates verification code and initiates verification process.
  void verifyValidate(BuildContext context, String userEmail,
      {String? password}) async {
    if (formKey.currentState!.validate()) {
      final otp = verificationControllers.text;
      final userDB = UserDB();
      try {
        final user = await userDB.getUserByEmail(userEmail);
        if (user != null && user.otpCode == otp) {
          await _processVerificationSuccess(context, user, password);
        } else {
          _showInvalidOTP(context);
        }
      } catch (e) {
        log('Error verifying OTP: $e');
        // Handle any errors
      }
    } else {
      log('Invalid OTP!');
    }
  }

  /// Resends OTP to the user's email.
  void resendOTP(BuildContext context, String email) async {
    try {
      final userDB = UserDB();
      final user = await userDB.getUserByEmail(email);

      if (user != null) {
        await _sendOTPAndUpdateDB(context, user);
      } else {
        log('User not found with email: $email');
      }
    } catch (e) {
      log('Error resending OTP: $e');
      // Handle error
    }
  }

  /// Clears verification code input field.
  void clear() {
    verificationControllers.clear();
  }

  /// Processes successful verification.
  Future<void> _processVerificationSuccess(
      BuildContext context, User user, String? password) async {
    final userDB = UserDB();
    await userDB.updateUserVerificationStatus(user.email, 1);

    if (password != null) {
      await userDB.updateUserPasswordByEmail(user.email, password);
    }

    Navigator.pushNamed(context, 'login');
  }

  /// Sends OTP to user's email and updates it in the database.
  Future<void> _sendOTPAndUpdateDB(BuildContext context, User user) async {
    final emailSender = EmailSender();
    String otp = emailSender.generateOTP();

    await emailSender.sendOTP(user.email, otp);
    await UserDB().updateUserOTPByEmail(user.email, otp);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('OTP resent successfully'),
          ],
        ),
      ),
    );
  }

  /// Shows a snackbar for invalid OTP.
  void _showInvalidOTP(BuildContext context) {
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
}
