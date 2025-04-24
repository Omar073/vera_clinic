import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/Controller/UpdateClientDetailsTEC.dart';

import '../../../Core/View/Reusable widgets/ActivityLevelDropdownMenu.dart';
import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

Widget dietPreferencesCardU() {
  return myCard(
    'تفضيلات الغذاء والنشاط',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          textDirection: TextDirection.rtl,
          spacing: 40,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                width: 300,
                child: MyInputField(
                  myController:
                  UpdateClientDetailsTEC.dietController,
                  hint: '',
                  label: 'النظام الغذائي',
                ),
              ),
            ),
            ActivityLevelDropdownMenu(
              activityLevelController:
              UpdateClientDetailsTEC.activityLevelController,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          ":الطعام المفضل",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 35,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: MyInputField(
                myController:
                    UpdateClientDetailsTEC.otherPreferredFoodsController,
                hint: '',
                label: 'أخري',
              ),
            ),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.fruitsController,
                text: "فاكهة"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.vegController,
                text: "خضار"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.dairyController,
                text: "ألبان"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.proteinController,
                text: "بروتينات"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.carbohydratesController,
                text: "كربوهايدرات"),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: WrapAlignment.end,
          children: [
            MyCheckBox(
                controller: UpdateClientDetailsTEC.sportsController,
                text: 'ممارسة الرياضة'),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.yoyoController,
                text: '(رجيم سابق) YOYO'),
          ],
        ),
      ],
    ),
  );
}
