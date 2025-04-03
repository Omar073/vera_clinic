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
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mBMIController,
                  label: 'مؤشر كتلة الجسم',
                  hint: 'BMI',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mPBFController,
                  label: 'نسبة الدهون',
                  hint: 'PBF',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mBMRController,
                  label: 'حد الحرق الأدني',
                  hint: 'BMR',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mWaterController,
                  hint: 'Water',
                  label: 'الماء',
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mMaxWeightController,
                  hint: '',
                  label: 'أقصي وزن',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mOptimalWeightController,
                  hint: '',
                  label: 'الوزن المثالي',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mMaxCaloriesController,
                  hint: '',
                  label: 'أقصي سعرات',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mDailyCaloriesController,
                  hint: '',
                  label: 'السعرات اليومية',
                ),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    ),
  );

}