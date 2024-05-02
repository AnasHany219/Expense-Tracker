import 'package:expense_tracker/features/dashboard/modules/profile-page/controller/cubit/profile_cubit.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/components/change_name.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/components/change_password.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/components/delete_account_button.dart';
import 'package:expense_tracker/features/dashboard/modules/profile-page/view/components/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String? email;

  const ProfilePage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ChangeName(email: email),
                  const SizedBox(height: 20),
                  ChangePassword(email: email),
                  const SizedBox(height: 20),
                  LogoutButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login', (Route<dynamic> route) => false);
                    },
                  ),
                  const SizedBox(height: 20),
                  DeleteAccountButton(email: email),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
