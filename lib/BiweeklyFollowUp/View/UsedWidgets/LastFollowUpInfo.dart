import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';

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
        "تفاصيل المتابعة السابقة",
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Date row
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MyTextBox(
                title: 'تاريخ المتابعة',
                value: getDateText(cmfu.mDate),
              ),
            ),
            // Wrap 1: Height | Weight | MuscleMass
            Wrap(
              textDirection: TextDirection.rtl,
              alignment: WrapAlignment.end,
              spacing: 70,
              runSpacing: 20,
              children: [
                MyTextBox(
                  title: 'الطول',
                  value: '${client.mHeight ?? 0} سم',
                ),
                MyTextBox(
                  title: 'الوزن',
                  value: '${client.mWeight ?? 0} كجم',
                ),
                MyTextBox(
                  title: "كتلة العضلات",
                  value: "${cmfu.mMuscleMass ?? 0}",
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Wrap 2: Water | PBF | BMR
            Wrap(
              textDirection: TextDirection.rtl,
              alignment: WrapAlignment.end,
              spacing: 70,
              runSpacing: 20,
              children: [
                MyTextBox(
                  title: "الماء",
                  value: cmfu.mWater ?? '',
                ),
                MyTextBox(
                  title: "نسبة الدهون",
                  value: "${cmfu.mPBF ?? 0}",
                ),
                MyTextBox(
                  title: "حد الحرق الأدني",
                  value: "${cmfu.mBMR ?? 0}",
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Wrap 3: MaxWeight | OptimalWeight | MaxCalories | DailyCalories
            Wrap(
              textDirection: TextDirection.rtl,
              alignment: WrapAlignment.end,
              spacing: 70,
              runSpacing: 20,
              children: [
                MyTextBox(
                  title: "أقصي وزن",
                  value: "${cmfu.mMaxWeight ?? 0}",
                ),
                MyTextBox(
                  title: "الوزن المثالي",
                  value: "${cmfu.mOptimalWeight ?? 0}",
                ),
                MyTextBox(
                  title: "أقصي سعرات",
                  value: "${cmfu.mMaxCalories ?? 0}",
                ),
                MyTextBox(
                  title: "السعرات اليومية",
                  value: "${cmfu.mDailyCalories ?? 0}",
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Notes section
              Wrap(
                textDirection: TextDirection.rtl,
                alignment: WrapAlignment.end,
                spacing: 70,
                runSpacing: 20,
                children: [
                  MyTextBox(
                    title: "ملاحظات",
                    value: cmfu.mNotes ?? '',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
