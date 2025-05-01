import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/WeeklyFollowUpUF.dart';

Widget WFUClientInfoCard(Client client) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
      "متابعة اسبوعية",
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Wrap(
          spacing: 60,
          textDirection: TextDirection.rtl,
          alignment: WrapAlignment.start,
          children: [
            MyTextBox(
                title: "الإسم", value: client.mName ?? 'مجهول'),
            MyTextBox(
                title: "السن",
                value: getAge(client.mBirthdate).isEmpty
                    ? 'مجهول'
                    : getAge(client.mBirthdate)),
            MyTextBox(
                title: "الوزن (كجم)",
                value: client.mWeight?.toString() ?? 'لا يوجد وزن'),
            MyTextBox(
                title: "إسم النظام الحالي",
                value: client.mDiet ?? 'لا يوجد نظام غذائي'),
          ],
        ),
      ),
    ),
  );
}
