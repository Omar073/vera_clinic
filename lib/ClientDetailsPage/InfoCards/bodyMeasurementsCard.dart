import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';

Widget bodyMeasurementsCard(
    Client? client, ClientMonthlyFollowUp? monthlyFollowUp) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: myCard(
      'قياسات الجسم',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: monthlyFollowUp != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextBox(
                    title: 'الطول',
                    value: '${client?.mHeight ?? 0} سم'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: 'الوزن',
                    value: '${client?.mWeight ?? 0} كجم'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: '(BMI)مؤشر كتلة الجسم',
                    value: '${monthlyFollowUp.mBMI ?? 0}'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextBox(
                    title: '(PBF)نسبة الدهون في الجسم',
                    value: '${monthlyFollowUp.mPBF ?? 0} %'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: 'الماء',
                    value: '${monthlyFollowUp.mWater ?? 0}'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextBox(
                    title: 'الوزن الأقصى',
                    value: '${monthlyFollowUp.mMaxWeight ?? 0} كجم'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: 'الوزن المثالي',
                    value: '${monthlyFollowUp.mOptimalWeight ?? 0} كجم'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: '(BMR)حد الحرق الأدني',
                    value: '${monthlyFollowUp.mBMR ?? 0}'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextBox(
                    title: 'السعرات الحرارية القصوى',
                    value: '${monthlyFollowUp.mMaxCalories ?? 0}'),
                const SizedBox(width: 60),
                MyTextBox(
                    title: 'السعرات الحرارية اليومية',
                    value: '${monthlyFollowUp.mDailyCalories ?? 0}'),
              ],
            ),
          ],
        )
            : const Center(
          child: Text('لا توجد بيانات قياسات الجسم'),
        ),
      ),
    ),
  );
}
