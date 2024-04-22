import 'package:expense_tracker/core/primary_button.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Center(
        child: PrimaryButton(
          buttonText: 'Add Expense',
        ),
      ),
    );
  }
}
