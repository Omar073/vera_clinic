import 'package:flutter/cupertino.dart';

import '../../CheckInPage/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

Widget personalInfoCard(Client? client, String area) {
  return detailsCard(
    'المعلومات الشخصية',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow('الاسم', client?.mName ?? 'Unknown'),
        infoRow('رقم الهاتف', client?.mClientPhoneNum ?? 'Unknown'),
        infoRow('الجنس', client?.mGender.name ?? 'Unknown'),
        infoRow(
            'تاريخ الميلاد',
            client?.mBirthdate?.toLocal().toString().split(' ')[0] ??
                'Unknown'),
        infoRow('المنطقة', area),
        infoRow(
            'نوع الاشتراك',
            getSubscriptionTypeLabel(
                client!.mSubscriptionType ?? SubscriptionType.none)),
      ],
    ),
  );
}