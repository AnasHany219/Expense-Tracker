import 'package:flutter/material.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';

/// Widget representing a single expense item in the list.
class ExpenseListItem extends StatelessWidget {
  /// The expense item to display.
  final Expense expense;

  /// Callback function triggered when the remove button is pressed.
  final VoidCallback onRemove;

  /// Constructs a new [ExpenseListItem] instance.
  const ExpenseListItem(
      {super.key, required this.expense, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Amount: ${expense.amount.toStringAsFixed(2)} \$'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${expense.category}'),
            Text('Date: ${expense.date}'),
            Text('Notes: ${expense.notes}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
