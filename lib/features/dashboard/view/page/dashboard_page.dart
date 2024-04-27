import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/controller/cubit/dashboard_cubit.dart';
import 'package:expense_tracker/features/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/features/dashboard/view/component/bottom_navbar.dart';

import 'package:expense_tracker/features/dashboard/modules/expenses/view/expense_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  final String? email; // Declare email variable
  final List<String> titles = const ['Home', 'Expenses'];

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
              centerTitle: true,
              backgroundColor: primaryColor,
              title: Text(
                titles[controller.selectedTapIndex],
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'add_expense');
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                )
              ],
            ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onChangeTapIndex,
              children: [
                Text('Home'),
                ExpensePage(),
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
