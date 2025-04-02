import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientConstantInfo.dart';
import '../UsedWidgets/TableRow.dart';

Widget clientInfoCard(Client? client, ClientConstantInfo clientConstantInfo,
    Visit lastClientVisit) {
  return Card(
    color: Colors.white,
    elevation: 2,
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
                {'label': 'اسم العميل', 'value': client?.mName ?? 'unknown'},
                {
                  'label': 'رقم العميل',
                  'value': client?.mClientPhoneNum ?? 'unknown'
                },
              ]),
              tableRow([
                {'label': 'المنطقة', 'value': clientConstantInfo.mArea},
                {
                  'label': 'تاريخ اخر زيارة',
                  'value':
                      "${lastClientVisit.mDate.day}/${lastClientVisit.mDate.month}/${lastClientVisit.mDate.year}"
                },
              ]),
            ],
          ),
        ],
      ),
    ),
  );
}
