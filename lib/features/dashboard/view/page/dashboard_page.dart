import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/controller/cubit/dashboard_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-add-page/view/page/expense_add_page.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/view/page/expense_list_page.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  final String? email; // Declare email variable
  final List<String> titles = const ['Home', 'Expense List', 'Profile'];

  const DashboardPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          DashboardCubit controller = context.read<DashboardCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpenseAddPage(email: email)),
                    );
                  },
                  icon: const Icon(Icons.add_box_rounded),
                  color: Colors.white,
                )
              ],
              title: Center(
                child: Text(
                  titles[controller.selectedTapIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              backgroundColor: primaryColor,
            ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onChangeTabIndex,
              children: [
                HomePage(email: email),
                ExpenseList(email: email),
                const Text('Profile'),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedTapIndex,
              onTap: controller.onChangeTabIndex,
              unselectedItemColor: primaryColor,
              showUnselectedLabels: true,
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, color: primaryColor),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'Expenses'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_2), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}
