import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void resetPasswordValidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'new_password');
    } else {
      log('Invalid!');
    }
  }

  void newPasswordValidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'verification_screen');
    } else {
      log('Invalid!');
    }
  }
}
