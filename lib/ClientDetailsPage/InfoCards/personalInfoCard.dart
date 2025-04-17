import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

import '../../CheckInPage/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';

Widget personalInfoCard(Client? client, String area) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: myCard(
      'المعلومات الشخصية',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextBox(
                  title: 'النوع',
                  value: client?.mGender.name ?? 'مجهول',
                ),
                const SizedBox(width: 60),
                MyTextBox(
                  title: 'رقم الهاتف',
                  value: client?.mClientPhoneNum ?? 'مجهول',
                ),
                const SizedBox(width: 60),
                MyTextBox(
                  title: 'الاسم',
                  value: client?.mName ?? 'مجهول',
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextBox(
                  title: 'نوع الاشتراك',
                  value: getSubscriptionTypeLabel(
                    client?.mSubscriptionType ?? SubscriptionType.none,
                  ),
                ),
                const SizedBox(width: 60),
                MyTextBox(
                  title: 'المنطقة',
                  value: area,
                ),
                const SizedBox(width: 60),
                MyTextBox(
                  title: 'تاريخ الميلاد',
                  value:
                      client?.mBirthdate?.toLocal().toString().split(' ')[0] ??
                          'مجهول',
                ),],
            ),

          ],
        ),
      ),
    ),
  );
}
