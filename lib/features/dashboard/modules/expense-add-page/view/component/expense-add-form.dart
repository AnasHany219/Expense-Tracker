// ignore_for_file: file_names

import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-add-page/controller/cubit/expense_add_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Form widget for adding a new expense.
class ExpenseAddForm extends StatefulWidget {
  /// The email address of the user.
  final String? email;

  /// Constructs a new [ExpenseAddForm] instance.
  const ExpenseAddForm({super.key, required this.email});

  @override
  State<ExpenseAddForm> createState() => _ExpenseAddFormState();
}

class _ExpenseAddFormState extends State<ExpenseAddForm> {
  late ExpenseAddCubit controller;

  @override
  void initState() {
    super.initState();
    controller = ExpenseAddCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => controller,
      child: BlocBuilder<ExpenseAddCubit, ExpenseAddState>(
        builder: (context, state) {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildInputForm('Amount'),
                buildInputForm('Category'),
                buildInputForm('Date'),
                buildInputForm('Note'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      controller.addExpenseValidate(context, widget.email!);
                    },
                    child: const PrimaryButton(buttonText: 'Add Expense'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds a TextFormField for input.
  Padding buildInputForm(String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: TextFormField(
          controller: label == 'Amount'
              ? controller.amountController
              : label == 'Category'
                  ? controller.categoryController
                  : label == 'Date'
                      ? controller.dateController
                      : controller.notesController,
          decoration: InputDecoration(
            hintText: label == 'Date' ? 'dd-mm-yyyy' : label,
            hintStyle: const TextStyle(
              color: textFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).buttonTheme.colorScheme!.background),
            ),
            prefixIcon: label == 'Amount'
                ? const Icon(Icons.attach_money)
                : label == 'Category'
                    ? const Icon(Icons.category)
                    : label == 'Date'
                        ? const Icon(Icons.calendar_today)
                        : const Icon(Icons.notes),
          ),
          validator: (value) {
            if (label == 'Amount') {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              // Check if the value is a valid number
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
            } else if (label == 'Date') {
              if (value == null ||
                  !RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                return 'Date format should be dd-mm-yyyy';
              }
            } else {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
            }
            return null;
          },
        ),
      );
}
