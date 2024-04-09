import 'package:flutter/material.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => const SizedBox(
          width: 50.0,
          child: TextField(
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
