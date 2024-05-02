// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final String? email;
  final UserDB userDB = UserDB();

  ProfileCubit(this.email) : super(ProfileInitial());

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

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
}
