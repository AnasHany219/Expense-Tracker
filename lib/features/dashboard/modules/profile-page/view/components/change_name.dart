import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/controller/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeName extends StatefulWidget {
  final String? email;
  const ChangeName({super.key, this.email});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  ProfileCubit controller = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  ParentCubit.instance.local["enter_new_name"] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8.0),
                buildInputForm(ParentCubit.instance.local["first_name"] ?? ""),
                const SizedBox(height: 8.0),
                buildInputForm(ParentCubit.instance.local["last_name"] ?? ""),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    controller.updateUserName(context, widget.email!);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).buttonTheme.colorScheme!.background),
                  ),
                  child: Text(
                    ParentCubit.instance.local["change_name"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
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
        style: Theme.of(context).textTheme.bodySmall,
        controller: label == ParentCubit.instance.local["first_name"]
            ? controller.firstName
            : controller.lastName,
        validator: Validator().nameValidator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.edit),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).buttonTheme.colorScheme!.background),
          ),
        ),
      ),
    );
  }
}
