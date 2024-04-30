import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/controller/cubit/expense_list_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/view/components/expense_list_item.dart';
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
                    : ListView.builder(
                        itemCount: controller.expenses.length,
                        itemBuilder: (context, index) {
                          final Expense expense = controller.expenses[index];
                          return ExpenseListItem(
                            expense: expense,
                            onRemove: () => _onRemove(context, expense),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }

  void _onRemove(BuildContext context, Expense expense) {
    final cubit = context.read<ExpenseListCubit>();
    cubit.removeExpense(context, expense.id!);
  }
}
