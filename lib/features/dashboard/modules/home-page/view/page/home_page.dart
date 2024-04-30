import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/components/expense_summary_charts.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/components/user_budget_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String? email;

  const HomePage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(email),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit controller = context.read<HomeCubit>();
          final double totalExpenses =
              state is HomeLoaded ? controller.calculateTotalExpenses() : 0.0;
          final String displayName = state is HomeLoading
              ? 'Loading...'
              : state is HomeEmpty
                  ? 'No-Name'
                  : state is HomeLoaded
                      ? '${state.user.firstName} ${state.user.lastName}'
                      : 'Unknown';
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text('Welcome, $displayName!', style: titleText),
                Column(
                  children: [
                    UserBudgetWidget(
                      totalExpenses: totalExpenses,
                      userBudget: controller.userBudget,
                      onUpdate: (newBudget) {
                        controller.updateUserBudget(newBudget);
                      },
                    ),
                    const SizedBox(height: 60),
                    ExpenseSummaryCharts(
                      expenseData: controller.getExpenseSummary(),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
