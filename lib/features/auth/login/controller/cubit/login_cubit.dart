// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/core/email_sender.dart';
import 'package:expense_tracker/features/auth/signup/model/user.dart';
import 'package:expense_tracker/features/auth/signup/model/database_repo/user_db.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void logInValidate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
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
      if (user == null) {
        ShowSnackbar.showSnackBar(
            context, 'Email not found', Colors.red, Icons.error);
        return;
      }

      if (user.password != password) {
        ShowSnackbar.showSnackBar(
            context, 'Incorrect password', Colors.red, Icons.error);
        return;
      }

      if (user.verified == 0 || user.verified == null) {
        ShowSnackbar.showSnackBar(
            context, 'Account not verified', Colors.red, Icons.error);
        await updateUserAndSendOTP(context, user);
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        'dashboard',
        arguments: user.email,
      );
    } catch (e) {
      log('Error checking credentials: $e');
    }
  }

  Future<void> updateUserAndSendOTP(BuildContext context, User user) async {
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
