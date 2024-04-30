import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/controller/cubit/expense_list_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/view/components/expense_list_item.dart';

/// Widget displaying a list of expenses.
class ExpenseList extends StatelessWidget {
  /// The email address of the current user.
  final String? email;

  /// Constructs a new [ExpenseList] instance.
  const ExpenseList({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseListCubit(email),
      child: BlocBuilder<ExpenseListCubit, ExpenseListState>(
        builder: (context, state) {
          final ExpenseListCubit controller = context.read<ExpenseListCubit>();
          return Scaffold(
            body: _buildBody(context, controller, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ExpenseListCubit controller,
      ExpenseListState state) {
    if (state is ExpenseListLoading) {
      return _buildLoadingState(context);
    } else if (state is ExpenseListEmpty) {
      return _buildEmptyState(context);
    } else {
      return _buildList(context, controller);
    }
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
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
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
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
      ),
    );
  }

  Widget _buildList(BuildContext context, ExpenseListCubit controller) {
    return ListView.builder(
      itemCount: controller.expenses.length,
      itemBuilder: (context, index) {
        final Expense expense = controller.expenses[index];
        return ExpenseListItem(
          expense: expense,
          onRemove: () => _onRemove(context, expense),
        );
      },
    );
  }

  void _onRemove(BuildContext context, Expense expense) {
    final cubit = context.read<ExpenseListCubit>();
    cubit.removeExpense(context, expense.id!);
  }
}
