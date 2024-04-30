import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/components/expense_summary_charts.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/components/user_budget_widget.dart';

/// A widget representing the home page of the dashboard.
class HomePage extends StatelessWidget {
  /// The email address of the user.
  final String? email;

  /// Constructs a new [HomePage] widget.
  const HomePage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(email),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit controller = context.read<HomeCubit>();
          final double totalExpenses =
              _calculateTotalExpenses(state, controller);
          final String displayName = _getDisplayName(state);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text('Welcome, $displayName!', style: titleText),
                _buildUserBudgetWidget(controller, totalExpenses),
                const SizedBox(height: 60),
                ExpenseSummaryCharts(
                  expenseData: controller.getExpenseSummary(),
                ),
                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Calculates the total expenses.
  double _calculateTotalExpenses(HomeState state, HomeCubit controller) {
    return state is HomeLoaded ? controller.calculateTotalExpenses() : 0.0;
  }

  /// Retrieves the display name based on the state.
  String _getDisplayName(HomeState state) {
    if (state is HomeLoading) {
      return 'Loading...';
    } else if (state is HomeEmpty) {
      return 'No-Name';
    } else if (state is HomeLoaded) {
      return '${state.user.firstName} ${state.user.lastName}';
    } else {
      return 'Unknown';
    }
  }

  /// Builds the user budget widget.
  Widget _buildUserBudgetWidget(HomeCubit controller, double totalExpenses) {
    return UserBudgetWidget(
      totalExpenses: totalExpenses,
      userBudget: controller.userBudget,
      onUpdate: (newBudget) {
        controller.updateUserBudget(newBudget);
      },
    );
  }
}
