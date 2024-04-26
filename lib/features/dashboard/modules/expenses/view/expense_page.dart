import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/controller/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseCubit(),
      child: BlocBuilder<ExpenseCubit, expenseState>(
        builder: (context, state) {
          final ExpenseCubit controller = context.read<ExpenseCubit>();

          return Scaffold(
              appBar: AppBar(
                title: const Text('View Expense'),
              ),
              body: state is expenseLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is expenseEmpty
                      ? const Center(child: Text('No expenses found'))
                      : state is expenseLoaded
                          ? GridView.builder(
                              itemCount: controller.expenses.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Text(
                                    controller.expenses[index].name ?? '');
                              },
                            )
                          : Container());
        },
      ),
    );
  }
}
