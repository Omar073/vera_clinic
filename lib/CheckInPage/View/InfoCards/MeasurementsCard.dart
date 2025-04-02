import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../UsedWidgets/TableRow.dart';

Widget measurementsCard(Client? client) {
  return Card(
    color: Colors.white,
    elevation: 2,
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
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            textDirection: TextDirection.rtl,
            children: [
              tableRow([
                {
                  'label': 'الطول',
                  'value': '${client?.mHeight ?? 'غير متوفر'} سم'
                },
                {
                  'label': 'الوزن',
                  'value': '${client?.mWeight ?? 'غير متوفر'} كجم'
                },
              ]),
            ],
          ),
        ],
      ),
    ),
  );
}
