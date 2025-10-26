import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';
import 'package:vera_clinic/MonthlyFollowUpsDetailsPage/MonthlyFollowUpsDetailsPage.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';

Widget bodyMeasurementsCard(
    BuildContext context, Client? client, ClientMonthlyFollowUp? monthlyFollowUp) {
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
                  Wrap(
                    alignment: WrapAlignment.start,
                    textDirection: TextDirection.rtl,
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      MyTextBox(
                          title: 'الطول', value: '${client?.mHeight ?? 0} سم'),
                      MyTextBox(
                          title: 'الوزن', value: '${client?.mWeight ?? 0} كجم'),
                      MyTextBox(
                          title: '(BMI) مؤشر كتلة الجسم',
                          value: '${monthlyFollowUp.mBMI ?? 0}'),
                      MyTextBox(
                          title: 'كتلة العضلات',
                          value: '${monthlyFollowUp.mMuscleMass ?? 0}'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.start,
                    textDirection: TextDirection.rtl,
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      MyTextBox(
                          title: '(BMR) معدل الحرق الأساسي',
                          value: '${monthlyFollowUp.mBMR ?? 0}'),
                      MyTextBox(
                          title: '(PBF) نسبة الدهون في الجسم',
                          value: '${monthlyFollowUp.mPBF ?? 0} %'),
                      MyTextBox(
                          title: 'الماء',
                          value: monthlyFollowUp.mWater ?? ''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.start,
                    textDirection: TextDirection.rtl,
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      MyTextBox(
                          title: 'الوزن الأقصى',
                          value: '${monthlyFollowUp.mMaxWeight ?? 0} كجم'),
                      MyTextBox(
                          title: 'الوزن المثالي',
                          value: '${monthlyFollowUp.mOptimalWeight ?? 0} كجم'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.start,
                    textDirection: TextDirection.rtl,
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      MyTextBox(
                          title: 'السعرات الحرارية اليومية',
                          value: '${monthlyFollowUp.mDailyCalories ?? 0}'),
                      MyTextBox(
                          title: 'السعرات الحرارية القصوى',
                          value: '${monthlyFollowUp.mMaxCalories ?? 0}'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Notes section
                    Wrap(
                      alignment: WrapAlignment.start,
                      textDirection: TextDirection.rtl,
                      spacing: 40,
                      runSpacing: 20,
                      children: [
                        MyTextBox(
                          title: 'ملاحظات',
                          value: monthlyFollowUp.mNotes ?? '',
                        ),
                      ],
                    ),
                ],
              )
            : const Center(
                child: Text('لا توجد بيانات قياسات الجسم'),
              ),
      ),
      action: ElevatedButton.icon(
        onPressed: client == null
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyFollowUpsDetailsPage(client: client),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        icon: const Icon(Icons.list),
        label: const Text('عرض الكل'),
      ),
    ),
  );
}
