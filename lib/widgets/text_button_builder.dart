import 'package:flutter/material.dart';

class TextButtonBuilder extends StatelessWidget {
  const TextButtonBuilder(
    this.page, {
    super.key,
    required this.text,
  });

  final Widget page;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => page,
          ),
          (route) => false,
        ),
      },
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
