// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
// import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/firebase_data.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';

part 'expense_list_state.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final String? email;
  List<Expense> expenses = []; // List variable to store expenses

  ExpenseListCubit(this.email) : super(ExpenseListLoading()) {
    init();
  }

  Future<void> init() async {
    emit(ExpenseListLoading());
    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);
    // expenses = await FirebaseRepo.instance.fetchExpenses(email: email);

    emit(expenses.isEmpty ? ExpenseListEmpty() : ExpenseListLoaded());
  }

  Future<void> removeExpense(BuildContext context, String id) async {
    try {
      // Call the deleteExpense method from local database
      final DatabaseRepo dbInstance = await DatabaseRepo.instance;
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
