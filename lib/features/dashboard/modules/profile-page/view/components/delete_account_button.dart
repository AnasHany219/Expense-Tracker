import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/controller/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountButton extends StatelessWidget {
  final String? email;

  const DeleteAccountButton({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final profileCubit = context.read<ProfileCubit>();
                profileCubit.deleteUserData(context, email);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
              child: Text(
                ParentCubit.instance.local['delete_account'],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ));
      },
    );
  }
}
