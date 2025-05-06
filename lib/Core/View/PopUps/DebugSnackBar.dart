import 'package:flutter/material.dart';

void showDebugSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message ?? '')),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 5),
    ),
  );
}
