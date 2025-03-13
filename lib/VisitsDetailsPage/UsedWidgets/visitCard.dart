import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/VisitsDetailsPage/UsedWidgets/visitTextBox.dart';

import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';

Widget visitCard(Visit visit, int num) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: myCard(
      'زيارة رقم $num',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: visitTextBox(
                    title: "النظام الغذائي",
                    value: visit.mDiet,
                  ),
                ),
                Expanded(
                  child: visitTextBox(
                    title: "التاريخ",
                    value: DateFormat('dd-MM-yyyy').format(visit.mDate),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: visitTextBox(
                    title: "الوزن",
                    value: "${visit.mWeight} كجم",
                  ),
                ),
                Expanded(
                  child: visitTextBox(
                    title: "مؤشر كتلة الجسم",
                    value: "${visit.mBMI}",
                  ),
                ),
              ],
            ),
            visitTextBox(
              title: "ملاحظات",
              value: visit.mVisitNotes,
            ),
          ],
        ),
      ),
    ),
  );
}