// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/snackbar.dart';
import 'package:expense_tracker/features/auth/signup/model/database_repo/user_db.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserDB userDB = UserDB();

  ProfileCubit() : super(ProfileInitial());

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updateUserName(BuildContext context, String email) async {
    if (formKey.currentState!.validate()) {
      String newFirstName = firstName.text;
      String newLastName = lastName.text;

      await userDB.updateUserNameByEmail(email, newFirstName, newLastName);

      ShowSnackbar.showSnackBar(
          context, 'Name has been Changed!', Colors.green, Icons.check_circle);

      // Clear the text fields
      firstName.clear();
      lastName.clear();
    } else {
      ShowSnackbar.showSnackBar(
          context, 'Name hasn\'t Changed!', Colors.red, Icons.error);
    }
  }

  Future<void> updatePassword(BuildContext context, String email) async {
    if (formKey.currentState!.validate()) {
      String newPasswordText = newPassword.text;

      await userDB.updateUserPasswordByEmail(email, newPasswordText);
      ShowSnackbar.showSnackBar(context, 'Password has been changed!',
          Colors.green, Icons.check_circle);

      // Clear the text fields
      newPassword.clear();
      confirmPassword.clear();
    } else {
      ShowSnackbar.showSnackBar(
          context, 'Password hasn\'t Changed!', Colors.red, Icons.error);
    }
  }

  Future<void> deleteUserData(BuildContext context, String? email) async {
    try {
      // Delete expenses associated with the provided email
      final DatabaseRepo expenseRepo = await DatabaseRepo.instance;
      await expenseRepo.deleteExpensesByEmail(email!);

      // Delete user data associated with the provided email
      await userDB.deleteUserByEmail(email);

      // Reset user budget to 0
      String budgetKey = 'userBudget_$email';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(budgetKey, 0);

      // Reset onboarding_completed to false
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setBool('onboarding_completed', false);

      // Navigate to the signup page after successful deletion
      Navigator.of(context).pushNamedAndRemoveUntil(
        'signup',
        (Route<dynamic> route) => false,
      );

      // Show a snackbar to inform the user
      ShowSnackbar.showSnackBar(context, 'Your account has been Deleted!',
          Colors.green, Icons.check_circle);
    } catch (e) {
      // Show a snackbar for error handling
      ShowSnackbar.showSnackBar(
          context, 'Your account hasn\'t Deleted!', Colors.red, Icons.error);
    }
  }
}
