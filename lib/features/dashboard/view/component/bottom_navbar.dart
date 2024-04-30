import 'package:flutter/material.dart';

/// A custom bottom navigation bar widget.
class BottomNavBar extends StatelessWidget {
  /// The index of the currently selected item.
  final int currentIndex;

  /// A callback function called when an item is tapped.
  final Function(int) onTap;

  /// Constructs a new [BottomNavBar] widget.
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Expense',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'View Expense',
        ),
      ],
    );
  }
}
