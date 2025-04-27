import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientConstantInfo.dart';

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
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 34,
            runSpacing: 8,
            children: [
              MyTextBox(title: 'اسم العميل', value: client?.mName ?? 'مجهول'),
              MyTextBox(
                  title: 'رقم هاتف العميل',
                  value: client?.mClientPhoneNum ?? 'مجهول'),
              MyTextBox(title: 'المنطقة', value: clientConstantInfo.mArea),
              MyTextBox(
                title: 'تاريخ اخر زيارة',
                value: lastClientVisit?.mVisitId != null
                    ? "${lastClientVisit?.mDate.day}/"
                        "${lastClientVisit?.mDate.month}/"
                        "${lastClientVisit?.mDate.year}"
                    : 'لا يوجد زيارات سابقة',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
