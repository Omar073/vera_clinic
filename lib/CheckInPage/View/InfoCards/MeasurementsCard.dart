import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../UsedWidgets/TableRow.dart';

Widget measurementsCard(Client? client) {
  return Card(
    color: Colors.white,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'القياسات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 34,
            runSpacing: 8,
            children: [
              MyTextBox(
                  title: 'الطول',
                  value: '${client?.mHeight ?? 'غير متوفر'} سم'),
              MyTextBox(
                  title: 'الوزن',
                  value: '${client?.mWeight ?? 'غير متوفر'} كجم'),
            ],
          ),
        ],
      ),
    ),
  );
}
