import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  const TextFieldBuilder({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
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
