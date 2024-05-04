import 'package:flutter/material.dart';

class ShowSnackbar {
  static void showSnackBar(
    BuildContext context,
    String message,
    Color color,
    IconData iconData,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: color), // Provided icon
            const SizedBox(width: 8), // Space between icon and text
            Text(message), // Error message
          ],
        ),
      ),
    );
  }
}
