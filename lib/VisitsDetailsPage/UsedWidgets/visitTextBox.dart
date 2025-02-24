import 'package:flutter/cupertino.dart';

  Widget visitTextBox({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          " : $title",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
