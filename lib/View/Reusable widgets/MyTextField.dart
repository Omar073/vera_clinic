import 'package:flutter/cupertino.dart';

class MyTextField extends StatefulWidget {
  final String title;
  final String value;
  const MyTextField({super.key, required this.title, required this.value});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          " : ${widget.title}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
