import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/BiweeklyFollowUpTEC.dart';

Widget newBiweeklyFollowUpForm() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: myCard(
      "تفاصيل المتابعة الحالية",
      Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              textDirection: TextDirection.rtl,
              spacing: 50,
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
                SizedBox(
                  width: 200,
                  child: MyInputField(
                    myController: BiweeklyFollowUpTEC.mMuscleMassController,
                    hint: 'Muscle Mass',
                    label: 'كتلة العضلات',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Wrap(
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
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: MyInputField(
              myController: BiweeklyFollowUpTEC.mNotesController,
              hint: 'أدخل ملاحظات إضافية...',
              label: 'ملاحظات',
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}