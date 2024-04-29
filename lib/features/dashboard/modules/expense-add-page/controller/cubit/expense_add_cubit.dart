// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
// import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/firebase_data.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';

part 'expense_add_state.dart';

class ExpenseAddCubit extends Cubit<ExpenseAddState> {
  ExpenseAddCubit() : super(ExpenseAddInitial());

  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addExpenseValidate(BuildContext context, String email) async {
    final amount = amountController.text;
    final category = categoryController.text;
    final date = dateController.text;
    final notes = notesController.text;

    // Validate amount field
    if (amount.isEmpty || !isNumeric(amount)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.red), // Error icon
              SizedBox(width: 8), // Space between icon and text
              Text('Amount must be a valid number'), // Error message
            ],
          ),
        ),
      );
      return;
    }

    if (category.isEmpty || date.isEmpty || notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.red), // Error icon
              SizedBox(width: 8), // Space between icon and text
              Text('All fields are required'), // Error message
            ],
          ),
        ),
      );
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
      final DatabaseRepo dbInstance = await DatabaseRepo.instance;
      await dbInstance.insertExpense(expense);
      // await FirebaseRepo.instance.insertExpense(expense);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Expense added successfully'),
            ],
          ),
        ),
      );
      clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.red), // Error icon
              SizedBox(width: 8), // Space between icon and text
              Text('Failed to add expense'), // Error message
            ],
          ),
        ),
      );
    }
  }

  void clearFields() {
    amountController.clear();
    categoryController.clear();
    dateController.clear();
    notesController.clear();
  }

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
