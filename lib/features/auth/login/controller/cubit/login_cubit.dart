// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
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
      // Check if email exists in the database
      final emailExists = await userDB.checkEmailExists(email);
      if (!emailExists) {
        showSnackBar(context, 'Email not found');
        return;
      }

      // Retrieve user from database
      final user = await userDB.getUserByEmail(email);
      if (user == null || user.password != password) {
        showSnackBar(context, 'Incorrect password');
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
        content: Text(message),
      ),
    );
  }
}
