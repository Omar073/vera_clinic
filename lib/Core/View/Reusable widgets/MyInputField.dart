import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  final int? maxLines;
  const MyInputField({
    super.key,
    required this.myController,
    required this.hint,
    required this.label,
    this.maxLines,
  });

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
        controller: widget.myController,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w300,
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
