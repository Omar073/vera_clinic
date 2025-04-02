import 'package:flutter/cupertino.dart';

class MyTextBox extends StatelessWidget {
  final String title;
  final String value;
  const MyTextBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // This helps shrink-wrap the children
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            " : $title",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
