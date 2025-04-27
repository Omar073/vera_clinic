import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/StaticCheckBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

import '../../Core/Model/Classes/ClientConstantInfo.dart';
import '../../Core/Model/Classes/PreferredFoods.dart';

Widget dietPreferencesCard(
  String diet,
  PreferredFoods? preferredFoods,
  ClientConstantInfo? clientConstantInfo,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: myCard(
      'تفضيلات النظام الغذائي',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 60,
              runSpacing: 20,
              children: [
                MyTextBox(title: 'النظام الغذائي', value: diet),
              ],
            ),
            if (preferredFoods != null) ...[
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 60,
                runSpacing: 20,
                children: [
                  staticCheckBox(
                    'الكربوهيدرات',
                    preferredFoods.mCarbohydrates,
                  ),
                  staticCheckBox(
                    'البروتينات',
                    preferredFoods.mProtein,
                  ),
                  staticCheckBox(
                    'منتجات الألبان',
                    preferredFoods.mDairy,
                  ),
                  staticCheckBox(
                    'الخضروات',
                    preferredFoods.mVeg,
                  ),
                  staticCheckBox(
                    'الفواكه',
                    preferredFoods.mFruits,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(children: [
                MyTextBox(title: 'أخرى', value: preferredFoods.mOthers)
              ]),
            ] else
              const Center(child: Text('لا توجد بيانات الأطعمة المفضلة')),
            if (clientConstantInfo != null)
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 60,
                runSpacing: 20,
                textDirection: TextDirection.rtl,
                children: [
                  staticCheckBox(
                    'الرياضة',
                    clientConstantInfo.mSports,
                  ),
                  staticCheckBox(
                    'رجيم سابق (YOYO)',
                    clientConstantInfo.mYOYO,
                  ),
                ],
              )
            else
              const Center(child: Text('لا توجد بيانات للعميل')),
          ],
        ),
      ),
    ),
  );
}
