import 'package:expense_tracker/features/dashboard/modules/profile-page/view/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/controller/cubit/dashboard_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-add-page/view/page/expense_add_page.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/view/page/expense_list_page.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/view/page/home_page.dart';

class DashboardPage extends StatelessWidget {
  final String? email; // Store email variable
  final List<String> titles = const ['Home', 'Expense List', 'Profile'];

  const DashboardPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final dashboardCubit = context.read<DashboardCubit>();

          return Scaffold(
            appBar: buildAppBar(context, dashboardCubit),
            body: buildPageView(context, dashboardCubit),
            bottomNavigationBar:
                buildBottomNavigationBar(context, dashboardCubit),
          );
        },
      ),
    );
  }

  /// Builds the app bar widget for the dashboard page.
  AppBar buildAppBar(BuildContext context, DashboardCubit dashboardCubit) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            navigateToAddExpensePage(context);
          },
          icon: const Icon(Icons.add_box_rounded),
          color: Colors.white,
        )
      ],
      title: buildAppBarTitle(dashboardCubit),
      backgroundColor: Theme.of(context).buttonTheme.colorScheme!.background,
    );
  }

  /// Builds the title widget for the app bar.
  Widget buildAppBarTitle(DashboardCubit dashboardCubit) {
    return Center(
      child: Text(
        titles[dashboardCubit.selectedTapIndex],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  /// Navigates to the expense add page.
  void navigateToAddExpensePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseAddPage(email: email),
      ),
    );
  }

  /// Builds the page view widget for the dashboard.
  Widget buildPageView(BuildContext context, DashboardCubit dashboardCubit) {
    return PageView(
      controller: dashboardCubit.pageController,
      onPageChanged: dashboardCubit.onChangeTabIndex,
      children: [
        HomePage(email: email),
        ExpenseList(email: email),
        ProfilePage(email: email),
      ],
    );
  }

  /// Builds the bottom navigation bar widget for the dashboard.
  Widget buildBottomNavigationBar(
      BuildContext context, DashboardCubit dashboardCubit) {
    return BottomNavigationBar(
      currentIndex: dashboardCubit.selectedTapIndex,
      onTap: dashboardCubit.onChangeTabIndex,
      unselectedItemColor:
          Theme.of(context).buttonTheme.colorScheme!.background,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
          fontSize: 15,
          color: Theme.of(context).buttonTheme.colorScheme!.background),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          label: 'Profile',
        ),
      ],
    );
  }
}
