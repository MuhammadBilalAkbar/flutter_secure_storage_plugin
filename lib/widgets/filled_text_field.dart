import 'package:flutter/material.dart';

class FilledTextField extends StatelessWidget {
  const FilledTextField({
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
      style: const TextStyle(fontSize: 24, color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: labelText,
        labelStyle: const TextStyle(fontSize: 24, color: Color(0xff4c505b)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xff4c505b), width: 2),
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
