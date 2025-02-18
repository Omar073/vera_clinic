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
                  hint: 'مؤشر كتلة الجسم',
                  label: 'BMI',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mPBFController,
                  hint: 'نسبة الدهون',
                  label: 'PBF',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mBMRController,
                  hint: 'حد الحرق الأدني',
                  label: 'BMR',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController: MonthlyFollowUpTEC.mWaterController,
                  hint: '',
                  label: 'Water',
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
                  label: 'Max weight',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mOptimalWeightController,
                  hint: '',
                  label: 'Optimal weight',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mMaxCaloriesController,
                  hint: '',
                  label: 'Max calories',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyInputField(
                  myController:
                  MonthlyFollowUpTEC.mDailyCaloriesController,
                  hint: '',
                  label: 'Daily calories',
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