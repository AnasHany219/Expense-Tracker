import 'package:expense_tracker/core/primary_button.dart';
import 'package:flutter/material.dart';

class ViewExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Expense'),
      ),
      body: Center(
        child: PrimaryButton(
          buttonText: 'View Expense',
        ),
      ),
    );
  }
}
