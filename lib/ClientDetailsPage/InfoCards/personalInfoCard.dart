import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

import '../../CheckInPage/Controller/CheckInPageUF.dart';
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
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 70,
              runSpacing: 20,
              children: [
                MyTextBox(
                  title: 'النوع',
                  value: getGenderLabel(client?.mGender ?? Gender.none),
                ),
                MyTextBox(
                  title: 'رقم الهاتف',
                  value: client?.mClientPhoneNum ?? 'مجهول',
                ),
                MyTextBox(
                  title: 'الاسم',
                  value: client?.mName ?? 'مجهول',
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing between rows
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 60,
              runSpacing: 20,
              children: [
                MyTextBox(
                    title: 'نوع الاشتراك',
                    value: getSubscriptionTypeLabel(
                        client?.mSubscriptionType ?? SubscriptionType.none)),
                MyTextBox(title: 'المنطقة', value: area),
                MyTextBox(
                    title: 'تاريخ الميلاد',
                    value: client?.mBirthdate
                            ?.toLocal()
                            .toString()
                            .split(' ')[0] ??
                        'مجهول'),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
