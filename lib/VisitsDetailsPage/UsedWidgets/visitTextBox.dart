import 'package:flutter/cupertino.dart';

  Widget visitTextBox({required String title, required String value}) {
    return Wrap(
      alignment: WrapAlignment.end,
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
