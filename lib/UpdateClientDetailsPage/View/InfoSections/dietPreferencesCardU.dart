import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/Controller/UpdateClientDetailsPageTEC.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                width: 300,
                child: MyInputField(
                  myController:
                  UpdateClientDetailsPageTEC.dietController,
                  hint: '',
                  label: 'النظام الغذائي',
                ),
              ),
            ),
            const SizedBox(width: 30),
            ActivityLevelDropdownMenu(
              activityLevelController:
              UpdateClientDetailsPageTEC.activityLevelController,
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
                    UpdateClientDetailsPageTEC.otherPreferredFoodsController,
                hint: '',
                label: 'أخري',
              ),
            ),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.fruitsController,
                text: "فاكهة"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.vegController,
                text: "خضار"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.dairyController,
                text: "ألبان"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.proteinController,
                text: "بروتينات"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.carbohydratesController,
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
                controller: UpdateClientDetailsPageTEC.sportsController,
                text: 'ممارسة الرياضة'),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.yoyoController,
                text: '(رجيم سابق) YOYO'),
          ],
        ),
      ],
    ),
  );
}
