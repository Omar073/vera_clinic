import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

class LastFollowUpInfo extends StatelessWidget {
  final Client client;
  final ClientMonthlyFollowUp cmfu;

  const LastFollowUpInfo({
    super.key,
    required this.client,
    required this.cmfu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: myCard(
        "تفاصيل المتابعة الشهرية السابقة",
        Wrap(
          alignment: WrapAlignment.start,
          textDirection: TextDirection.rtl,
          spacing: 50,
          runSpacing: 30,
          children: [
            MyTextBox(
              title: 'الوزن',
              value: '${client.mWeight ?? 0} كجم',
            ),
            MyTextBox(
              title: '(BMI) مؤشر كتلة الجسم',
              value: "${cmfu.mBMI}",
            ),
            MyTextBox(
              title: "نسبة الدهون",
              value: "${cmfu.mPBF}",
            ),
            MyTextBox(
              title: "كتلة العضلات",
              value: "${cmfu.mMuscleMass}",
            ),
            MyTextBox(
              title: "حد الحرق الأدني",
              value: "${cmfu.mBMR}",
            ),
            MyTextBox(
              title: "الماء",
              value: cmfu.mWater ?? '',
            ),
            MyTextBox(
              title: "أقصي وزن",
              value: "${cmfu.mMaxWeight}",
            ),
            MyTextBox(
              title: "الوزن المثالي",
              value: "${cmfu.mOptimalWeight}",
            ),
            MyTextBox(
              title: "أقصي سعرات",
              value: "${cmfu.mMaxCalories}",
            ),
            MyTextBox(
              title: "السعرات اليومية",
              value: "${cmfu.mDailyCalories}",
            ),
          ],
        ),
      ),
    );
  }
}
