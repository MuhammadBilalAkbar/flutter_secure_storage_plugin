import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  const TextFieldBuilder({
    super.key,
    required this.emailController,
    required this.labelText,
    required this.validator,
  });

  final TextEditingController emailController;
  final String labelText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      autofocus: false,
      style: const TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 24),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 24,
        ),
      ),
      validator: validator,
    );
  }
}
