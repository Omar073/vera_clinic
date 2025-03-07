import 'package:flutter/material.dart';

void showRequiredFieldSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text('$message لا يمكن أن يكون فارغًا')),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
