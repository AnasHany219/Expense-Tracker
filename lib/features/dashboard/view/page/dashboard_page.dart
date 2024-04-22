import 'package:expense_tracker/features/dashboard/view/component/bottom_navbar.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String? email; // Declare email variable

  const DashboardPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker Dashboard'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Expense Tracker!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // Handle navigation to different screens based on index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'add_expense');
              break;
            case 1:
              Navigator.pushNamed(context, 'dash_board');
              break;
            case 2:
              Navigator.pushNamed(context, 'view_expense');
              break;
          }
        },
      ),
    );
  }
}
