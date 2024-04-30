// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart'; // import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/firebase_data.dart';
import 'package:flutter/material.dart';

part 'expense_list_state.dart';

/// Cubit for managing the state of the expense list.
class ExpenseListCubit extends Cubit<ExpenseListState> {
  /// The email address of the user.
  final String? email;

  /// List variable to store expenses.
  List<Expense> expenses = [];

  /// Constructs a new [ExpenseListCubit] instance.
  ExpenseListCubit(this.email) : super(ExpenseListLoading()) {
    init();
  }

  /// Initializes the cubit.
  Future<void> init() async {
    emit(ExpenseListLoading());
    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);
    // expenses = await FirebaseRepo.instance.fetchExpenses(email: email);

    emit(expenses.isEmpty ? ExpenseListEmpty() : ExpenseListLoaded());
  }

  /// Removes an expense.
  Future<void> removeExpense(BuildContext context, String id) async {
    try {
      final DatabaseRepo dbInstance = await DatabaseRepo.instance;

      // Call the deleteExpense method from local database
      await dbInstance.deleteExpense(id: id);

      // Call the deleteExpense method from firebase
      // await FirebaseRepo.instance.deleteExpense(id: id);

      init();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Expense removed successfully'),
            ],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.red), // Error icon
              SizedBox(width: 8), // Space between icon and text
              Text('Failed to remove expense'), // Error message
            ],
          ),
        ),
      );
    }
  }
}
