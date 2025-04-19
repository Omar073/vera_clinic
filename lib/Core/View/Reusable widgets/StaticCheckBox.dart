import 'package:flutter/material.dart';

Widget staticCheckBox(String title, bool value) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Icon(
          value ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.green,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
