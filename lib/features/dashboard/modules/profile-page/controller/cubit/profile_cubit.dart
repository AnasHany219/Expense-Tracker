// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name has been Changed!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name has not been Changed!'),
        ),
      );
    }
  }

  Future<void> updatePassword(BuildContext context, String email) async {
    if (formKey.currentState!.validate()) {
      String newPasswordText = newPassword.text;

      await userDB.updateUserPasswordByEmail(email, newPasswordText);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has been changed!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password change failed! Please check your inputs.'),
        ),
      );
    }
  }

  Future<void> deleteUserData(BuildContext context, String? email) async {
    try {
      // Delete expenses associated with the provided email
      final DatabaseRepo expenseRepo = await DatabaseRepo.instance;
      await expenseRepo.deleteExpensesByEmail(email!);

      // Delete user data associated with the provided email
      await userDB.deleteUserByEmail(email);

      // Navigate to the signup page after successful deletion
      Navigator.of(context).pushNamedAndRemoveUntil(
        'singup',
        (Route<dynamic> route) => false,
      );

      // Show a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your account has been Deleted!'),
        ),
      );
    } catch (e) {
      // Show a snackbar for error handling
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error!'),
        ),
      );
    }
  }
}
