import 'package:flutter/material.dart';

SnackBar showSnackBar(String text) => SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text(
        text,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
