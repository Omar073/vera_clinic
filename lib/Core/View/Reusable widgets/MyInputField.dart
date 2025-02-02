import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  final int? maxLines; // Add maxLines parameter
  final double? width; // Add width parameter for flexibility

  const MyInputField({
    super.key,
    required this.myController,
    required this.hint,
    required this.label,
    this.maxLines,
    this.width = 200, // Default width
  });

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
        controller: widget.myController,
        maxLines: widget.maxLines ?? 1, // Use maxLines parameter
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.withOpacity(1),
            fontWeight: FontWeight.w300,
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                    fontSize: 16), //Customize label style if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
