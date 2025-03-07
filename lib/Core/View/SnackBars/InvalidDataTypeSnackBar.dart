import 'package:flutter/material.dart';

void showInvalidDataTypeSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text('$message يقبل الأرقام فقط ولا يسمح بإدخال أحرف')),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}