import 'package:flutter/material.dart';

Widget infoCard(String title, Widget content) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Column(
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
            ],
          ),
          // const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              content,
            ],
          ),
        ],
      ),
    ),
  );
}