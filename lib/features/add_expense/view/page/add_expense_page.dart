import 'dart:developer';

import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/features/add_expense/view/component/add_expense_form.dart';
import 'package:expense_tracker/features/auth/login/view/component/login_form.dart';
import 'package:expense_tracker/features/auth/login/view/page/login.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddExpenseForm(),
          ],
        ),
      ),
    );
  }
}
