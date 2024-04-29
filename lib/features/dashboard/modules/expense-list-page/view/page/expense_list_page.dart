import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/controller/cubit/expense_list_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatelessWidget {
  final String? email;

  const ExpenseList({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseListCubit(email),
      child: BlocBuilder<ExpenseListCubit, ExpenseListState>(
        builder: (context, state) {
          final ExpenseListCubit controller = context.read<ExpenseListCubit>();
          return Scaffold(
            body: state is ExpenseListLoading
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: secondaryColor),
                      Text(
                        'Loading expenses',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ))
                : state is ExpenseListEmpty
                    ? const Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 100,
                            color: secondaryColor,
                          ),
                          Text(
                            'No expenses found',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: controller.expenses.length,
                        itemBuilder: (context, index) {
                          final Expense expense = controller.expenses[index];
                          return Card(
                            child: ListTile(
                              title: Text('Amount: ${expense.amount}'),
                              subtitle: Text('Category: ${expense.category}'),
                              // Add more fields as needed
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
