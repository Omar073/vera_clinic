import 'package:flutter/material.dart';

void showMySnackBar(BuildContext context, String? message, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message!)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}
