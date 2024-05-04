// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/core/snackbar.dart';
import 'package:expense_tracker/features/auth/signup/model/user.dart';
import 'package:expense_tracker/features/auth/signup/model/database_repo/user_db.dart';
import 'package:flutter/material.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  // Text controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key for form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Validates form input and initiates the signup process.
  Future<void> signUpValidate(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final user = _createUserFromInput();
      final emailExists = await _checkEmailExists(user.email);

      if (emailExists) {
        ShowSnackbar.showSnackBar(
            context, 'Email already exists', Colors.red, Icons.error);
      } else {
        try {
          await _insertUserIntoDatabase(user);
          await _updateUserAndSendOTP(context, user);
        } catch (error) {
          ShowSnackbar.showSnackBar(
              context, 'Error during signup', Colors.red, Icons.error);
          debugPrint('Error during signup: $error');
          // Handle other errors related to signup process if needed
        }
      }
    } else {
      debugPrint('Invalid!');
    }
  }

  /// Creates a User object from input field values.
  User _createUserFromInput() {
    return User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  /// Checks if the email already exists in the database.
  Future<bool> _checkEmailExists(String email) async {
    return UserDB().checkEmailExists(email);
  }

  /// Inserts the user data into the database.
  Future<void> _insertUserIntoDatabase(User user) async {
    await UserDB().insertUser(user);
  }

  /// Updates the user OTP in the database and sends OTP to the user's email.
  Future<void> _updateUserAndSendOTP(BuildContext context, User user) async {
    final emailSender = EmailSender();
    final otp = emailSender.generateOTP();
    await emailSender.sendOTP(user.email, otp);
    await UserDB().updateUserOTPByEmail(user.email, otp);
    Navigator.pushNamed(
      context,
      'verification_screen',
      arguments: user.email,
    );
  }
}
