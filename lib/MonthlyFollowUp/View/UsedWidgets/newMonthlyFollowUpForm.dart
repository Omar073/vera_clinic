import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/MonthlyFollowUpTEC.dart';

Widget newMonthlyFollowUpForm() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: myCard(
      "تفاصيل المتابعة الشهرية الحالية",
      Column(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            textDirection: TextDirection.rtl,
            spacing: 40,
            runSpacing: 20,
            children: [
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mBMIController,
                  label: 'مؤشر كتلة الجسم',
                  hint: 'BMI',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mPBFController,
                  label: 'نسبة الدهون',
                  hint: 'PBF',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  label: "معدل الحرق الأساسي",
                  myController: MonthlyFollowUpTEC.mBMRController,
                  hint: 'BMR',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mWaterController,
                  hint: 'Water',
                  label: 'الماء',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.start,
            textDirection: TextDirection.rtl,
            spacing: 40,
            runSpacing: 20,
            children: [
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mMaxWeightController,
                  hint: '',
                  label: 'أقصي وزن',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mOptimalWeightController,
                  hint: '',
                  label: 'الوزن المثالي',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mMaxCaloriesController,
                  hint: '',
                  label: 'أقصي سعرات',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mDailyCaloriesController,
                  hint: '',
                  label: 'السعرات اليومية',
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}