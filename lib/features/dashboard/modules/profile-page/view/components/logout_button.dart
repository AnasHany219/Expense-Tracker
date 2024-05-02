import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final Function() onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.green, // You can customize the color here
          ),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
