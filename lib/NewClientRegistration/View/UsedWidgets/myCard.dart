import 'package:flutter/material.dart';

Widget myCard(String title, Widget content) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          // const SizedBox(height: 8),
          content,
        ],
      ),
    ),
  );
}
