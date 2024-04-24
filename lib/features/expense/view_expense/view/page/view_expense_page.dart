import 'package:expense_tracker/core/primary_button.dart';
import 'package:flutter/material.dart';

class ViewExpensePage extends StatelessWidget {
  const ViewExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Expense'),
      ),
      body: const Center(
        child: PrimaryButton(
          buttonText: 'View Expense',
        ),
      ),
    );
  }
}
