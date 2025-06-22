import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/BiweeklyFollowUpTEC.dart';

Widget newBiweeklyFollowUpForm() {
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
                  myController: BiweeklyFollowUpTEC.mWeightController,
                  label: 'الوزن (كجم)',
                  hint: 'Weight (kg)',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: BiweeklyFollowUpTEC.mPBFController,
                  label: 'نسبة الدهون',
                  hint: 'PBF',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  label: "معدل الحرق الأساسي",
                  myController: BiweeklyFollowUpTEC.mBMRController,
                  hint: 'BMR',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: BiweeklyFollowUpTEC.mWaterController,
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
                  myController: BiweeklyFollowUpTEC.mMaxWeightController,
                  hint: '',
                  label: 'أقصي وزن',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: BiweeklyFollowUpTEC.mOptimalWeightController,
                  hint: '',
                  label: 'الوزن المثالي',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: BiweeklyFollowUpTEC.mMaxCaloriesController,
                  hint: '',
                  label: 'أقصي سعرات',
                ),
              ),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: BiweeklyFollowUpTEC.mDailyCaloriesController,
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