import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-add-page/controller/cubit/expense_add_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-add-page/view/component/expense-add-form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseAddPage extends StatelessWidget {
  final String? email;
  const ExpenseAddPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Add Expense",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: BlocProvider(
        create: (context) =>
            ExpenseAddCubit(), // Provide the controller cubit bloc
        child: ExpenseAddForm(email: email),
      ),
    );
  }
}
