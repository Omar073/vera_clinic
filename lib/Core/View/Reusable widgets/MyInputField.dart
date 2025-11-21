import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  const MyInputField({
    super.key,
    required this.myController,
    required this.hint,
    required this.label,
    this.maxLines,
    this.textStyle,
    this.textAlign = TextAlign.start,
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
        style: widget.textStyle ?? const TextStyle(fontSize: 20),
        textAlign: widget.textAlign,
        controller: widget.myController,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black, // Change this to your desired color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
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
