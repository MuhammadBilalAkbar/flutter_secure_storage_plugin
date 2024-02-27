import 'package:flutter/material.dart';

class BuildTextButton extends StatelessWidget {
  const BuildTextButton({
    super.key,
    required this.color,
    required this.widget,
    required this.text,
  });

  final String text;
  final Color color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: color,
          color: color,
          fontSize: 18,
        ),
      ),
    );
  }
}
