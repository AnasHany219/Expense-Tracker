import 'package:expense_tracker/core/primary_button.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: const Center(
        child: PrimaryButton(
          buttonText: 'Add Expense',
        ),
      ),
    );
  }
}
