// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/snackbar.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';

part 'expense_add_state.dart';

/// Cubit responsible for managing adding expenses.
class ExpenseAddCubit extends Cubit<ExpenseAddState> {
  ExpenseAddCubit() : super(ExpenseAddInitial());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Adds the expense after validating the input fields.
  Future<void> addExpenseValidate(BuildContext context, String email) async {
    final amount = amountController.text;
    final category = categoryController.text;
    final date = dateController.text;
    final notes = notesController.text;

    // Validate amount field
    if (amount.isEmpty || !isNumeric(amount)) {
      ShowSnackbar.showSnackBar(
          context, 'Amount must be a valid number', Colors.red, Icons.error);
      return;
    }

    if (category.isEmpty || date.isEmpty || notes.isEmpty) {
      ShowSnackbar.showSnackBar(
          context, 'All fields are required', Colors.red, Icons.error);
      return;
    }

    final expense = Expense(
      email: email,
      amount: double.parse(amount),
      category: category,
      date: date,
      notes: notes,
    );

    try {
      final dbInstance = await DatabaseRepo.instance;
      await dbInstance.insertExpense(expense);

      // inserting data in firebase
      // await FirebaseRepo.instance.insertExpense(expense);

      ShowSnackbar.showSnackBar(context, 'Expense added successfully',
          Colors.green, Icons.check_circle);
      clearFields();
    } catch (e) {
      ShowSnackbar.showSnackBar(
          context, 'Failed to add expense', Colors.red, Icons.error);
    }
  }

  /// Clears all input fields.
  void clearFields() {
    amountController.clear();
    categoryController.clear();
    dateController.clear();
    notesController.clear();
  }

  /// Checks if a string is numeric.
  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
