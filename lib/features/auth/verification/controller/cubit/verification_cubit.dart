import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  TextEditingController verificationControllers = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void verifyValidate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, 'login');
    } else {
      log('Invalid!');
    }
  }

  void clear() {
    verificationControllers.clear();
  }
}
