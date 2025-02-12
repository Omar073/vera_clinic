import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientConstantInfo.dart';
import '../UsedWidgets/TableRow.dart';

Widget clientInfoCard(Client? client, ClientConstantInfo clientConstantInfo, Visit lastClientVisit) {
  return Card(
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
              tableRow(
                'اسم العميل',
                client?.mName ?? 'unknown',
                'رقم العميل',
                client?.mClientPhoneNum ?? 'unknown',
              ),
                tableRow(
                'المنطقة',
                clientConstantInfo.mArea,
                'تاريخ اخر زيارة',
                "${lastClientVisit.mDate.day}/${lastClientVisit.mDate.month}/${lastClientVisit.mDate.year}",
              ),
              // _buildTableRow(
              //   'تاريخ اخر متابعة',
              //   "${visit.mDate.day}/${visit.mDate.month}/${visit.mDate.year}",
              //   'منطقة العميل',
              //   'placeholder',
              //   // await clientConstantInfoProvider
              //   //     .getClientConstantInfoByClientId(client.mClientId)
              //   //     ?.area ?? 'Unknown',
              //   //todo: fix this
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}