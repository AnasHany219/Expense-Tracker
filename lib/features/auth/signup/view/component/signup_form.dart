import 'package:expense_tracker/core/parent_cubit/parent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/primary_button.dart';
import 'package:expense_tracker/core/text_style.dart';
import 'package:expense_tracker/core/validation.dart';
import 'package:expense_tracker/features/auth/signup/controller/cubit/registration_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;

  RegistrationCubit controller = RegistrationCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                _buildInputFormField(context, 'First Name',
                    controller.firstNameController, Validator().nameValidator),
                _buildInputFormField(context, 'Last Name',
                    controller.lastNameController, Validator().nameValidator),
                _buildInputFormField(context, 'Email',
                    controller.emailController, Validator().emailValidator),
                _buildInputFormField(
                    context,
                    'Password',
                    controller.passwordController,
                    Validator().passwordValidator),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      controller.signUpValidate(context);
                    },
                    child: const PrimaryButton(buttonText: 'Verification'),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding _buildInputFormField(BuildContext context, String label,
      TextEditingController controller, var validator) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: BlocProvider<ParentCubit>(
          create: (context) => ParentCubit.instance,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: controller,
            obscureText: label == 'Password' ? _isObscure : false,
            validator: validator,
            decoration: InputDecoration(
              hintText: ParentCubit.instance.local[label]??label,
              prefixIcon: label == 'Password'
                  ? const Icon(Icons.password_outlined)
                  : label == 'Email'
                      ? const Icon(Icons.email)
                      : null,
              hintStyle: Theme.of(context).textTheme.titleSmall,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .background)),
              suffixIcon: label == 'Password'
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .background,
                      ),
                    )
                  : null,
            ),
          ),
        ));
  }
}
