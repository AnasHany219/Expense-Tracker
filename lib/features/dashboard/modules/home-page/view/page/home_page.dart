import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String? email;
  const HomePage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(email),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit controller = context.read<HomeCubit>();
          double totalExpenses =
              state is HomeLoaded ? controller.calculateTotalExpenses() : 0.0;
          String displayName = state is HomeLoading
              ? 'Loading...'
              : state is HomeEmpty
                  ? 'No-Name'
                  : state is HomeLoaded
                      ? '${state.user.firstName} ${state.user.lastName}'
                      : 'Unknown';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Welcome, $displayName!', style: titleText),
                    const SizedBox(height: 10),
                    // Total Expenses Display
                    Text(
                        'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
                        style: subTitle),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
