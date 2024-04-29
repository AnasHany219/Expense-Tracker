import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'expense_add_state.dart';

class ExpenseAddCubit extends Cubit<ExpenseAddState> {
  ExpenseAddCubit() : super(ExpenseAddInitial());

  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addExpenseValidate(BuildContext context, String email) async {
    final amount = amountController.text.trim();
    final category = categoryController.text.trim();
    final date = dateController.text.trim();
    final notes = notesController.text.trim();

    if (amount.isEmpty || category.isEmpty || date.isEmpty || notes.isEmpty) {
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
}
