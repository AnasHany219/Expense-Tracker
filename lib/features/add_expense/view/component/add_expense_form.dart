import 'dart:math';

import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/add_expense/controller/cubit/add_expense_cubit.dart';
import 'package:expense_tracker/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/local_db_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  AddExpenseCubit controller = AddExpenseCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<AddExpenseCubit, AddExpenseState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildInputForm('Product'),
                buildInputForm('Price'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      // controller.logInValidate(context);
                    },
                    child: PrimaryButton(
                      buttonText: 'Add Expense',
                      onPressed: () async {
                        await (await DatabaseRepo.instance).insert(
                            name: controller.productController.text,
                            cost: controller.priceController.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildInputForm(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: label == "price"
              ? const Icon(Icons.money_outlined)
              : const Icon(Icons.production_quantity_limits),
          labelStyle: const TextStyle(
            color: textFieldColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }
}
