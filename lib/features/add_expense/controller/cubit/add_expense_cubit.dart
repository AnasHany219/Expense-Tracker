// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseInitial());

  final productController = TextEditingController();
  final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();


}
