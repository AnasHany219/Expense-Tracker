import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ParentCubit.instance.changeMode();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 50)),
                    ),
                    child: Text(
                      ParentCubit.instance.local["change_mode"] ??
                          "Change Mode",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      ParentCubit.instance.changeLang();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 50)),
                    ),
                    child: Text(
                      ParentCubit.instance.local["change_lang"] ??
                          "Change Language",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  LogoutButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login', (Route<dynamic> route) => false);
                    },
                  ),
                  const SizedBox(height: 10),
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
