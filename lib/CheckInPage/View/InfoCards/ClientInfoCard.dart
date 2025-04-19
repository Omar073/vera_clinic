import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientConstantInfo.dart';
import '../UsedWidgets/TableRow.dart';

Widget clientInfoCard(Client? client, ClientConstantInfo clientConstantInfo,
    Visit? lastClientVisit) {
  return Card(
    color: Colors.white,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'معلومات العميل',
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
                {'label': 'اسم العميل', 'value': client?.mName ?? 'مجهول'},
                {
                  'label': 'رقم هاتف العميل',
                  'value': client?.mClientPhoneNum ?? 'مجهول'
                },
              ]),
              tableRow([
                {'label': 'المنطقة', 'value': clientConstantInfo.mArea},
                {
                  'label': 'تاريخ اخر زيارة',
                  'value': lastClientVisit?.mVisitId != null
                      ? "${lastClientVisit?.mDate.day}/"
                          "${lastClientVisit?.mDate.month}/"
                          "${lastClientVisit?.mDate.year}"
                      : 'لا يوجد زيارات سابقة',
                },
              ]),
            ],
          ),
        ],
      ),
    ),
  );
}
