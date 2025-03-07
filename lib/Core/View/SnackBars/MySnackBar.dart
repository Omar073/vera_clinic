import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  final String? message;
  final Color? color;
  const MySnackBar({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message!)),
        backgroundColor: color,
      ),
    );
    return Container(); // Return an empty container or any other widget
  }
}
