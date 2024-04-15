// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void logInValidate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'login');
    } else {
      log('Invalid!');
    }
  }
}
