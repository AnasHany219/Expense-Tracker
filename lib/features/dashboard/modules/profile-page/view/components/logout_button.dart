import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: Text(
          ParentCubit.instance.local["log_out"] ?? "",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
