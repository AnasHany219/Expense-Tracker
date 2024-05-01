import 'package:flutter/material.dart';
import 'package:expense_tracker/core/text_style.dart';

/// A widget representing the user budget information.
class UserBudgetWidget extends StatelessWidget {
  /// The total expenses of the user.
  final double totalExpenses;

  /// The user's budget.
  final double userBudget;

  /// A callback function to update the user's budget.
  final Function(double) onUpdate;

  /// Constructs a new [UserBudgetWidget] instance.
  const UserBudgetWidget({
    super.key,
    required this.totalExpenses,
    required this.userBudget,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final difference = userBudget - totalExpenses;
    final isBudgetExceeded = difference < 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spending Limit: ${userBudget.toStringAsFixed(2)} \$ ',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditBudgetModal(context);
                },
              ),
            ],
          ),
          Text(
            'Total Spending: ${totalExpenses.toStringAsFixed(2)} \$ ',
            style: const TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Balance: ${difference.toStringAsFixed(2)} \$ ',
            style: TextStyle(
              fontSize: 18,
              color: isBudgetExceeded ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Displays a modal bottom sheet to edit the user's budget.
  void _showEditBudgetModal(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: userBudget.toStringAsFixed(2));

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter new budget',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return double.tryParse(value!) == null
                      ? 'Please enter a valid number'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final double newBudget =
                      double.tryParse(controller.text) ?? 0.0;
                  onUpdate(newBudget);
                  Navigator.pop(context);
                },
                child: const Text('Update Budget'),
              ),
            ],
          ),
        );
      },
    );
  }
}
