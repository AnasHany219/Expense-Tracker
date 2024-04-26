import 'package:expense_tracker/features/dashboard/controller/cubit/dashboard_cubit.dart';
import 'package:expense_tracker/features/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/features/dashboard/view/component/bottom_navbar.dart';
import 'package:expense_tracker/features/dashboard/modules/add_expense/page/add_expense_page.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/view/expense_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  final String? email; // Declare email variable

  const DashboardPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardController(),
      child: BlocBuilder<DashboardController, DashboardState>(
        builder: (context, state) {
          DashboardController controller = context.read<DashboardController>();
          return Scaffold(
            appBar: AppBar(
                // title: const Text('Expense Tracker Dashboard'),
                ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onChangeTapIndex,
              children: [
                const Text('Home'),
                const ExpensePage(),
                const AddExpensePage(),
              ],
            ),
            bottomNavigationBar: BottomNavBar(
              currentIndex: controller.selectedTapIndex,
              onTap: controller.onChangeTapIndex,
            ),
          );
        },
      ),
    );
  }
}
