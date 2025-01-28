import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  const MyInputField(
      {super.key,
        required this.myController,
        required this.hint,
        required this.label});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
        controller: widget.myController,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.withOpacity(1), // Adjust opacity
            fontWeight: FontWeight.w300, // Adjust thickness
          ),
          label: Row(
            mainAxisAlignment:
            MainAxisAlignment.end, // Aligns to the other side
            children: [
              Text(
                widget.label ?? '', // Display the label text
                style: const TextStyle(
                    fontSize: 16), // Customize label style if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}