import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  const PrimaryButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).buttonTheme.colorScheme!.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .buttonTheme
                .colorScheme!
                .background
                .withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        ParentCubit.instance.local[buttonText] ?? buttonText,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
