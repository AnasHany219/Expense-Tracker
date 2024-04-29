import 'package:flutter/material.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  const ExpenseListItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Amount: ${expense.amount}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${expense.category}'),
            Text('Date: ${expense.date}'),
            Text('Notes: ${expense.notes}'),
          ],
        ),
      ),
    );
  }
}
