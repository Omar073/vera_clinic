import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../UsedWidgets/ActivityLevelDropdownMenu.dart';
import '../UsedWidgets/MyCheckBox.dart';

Widget dietPreferencesCard() {
  return myCard(
    'تفضيلات الغذاء والنشاط',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 16),
            ActivityLevelDropdownMenu(
              activityLevelController:
                  ClientRegistrationTEC.activityLevelController,
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
                    ClientRegistrationTEC.othersPreferredFoodsController,
                hint: 'أخري',
                label: 'أخري',
              ),
            ),
            MyCheckBox(
                controller: ClientRegistrationTEC.fruitsController,
                text: "فاكهة"),
            MyCheckBox(
                controller: ClientRegistrationTEC.vegController,
                text: "خضار"),
            MyCheckBox(
                controller: ClientRegistrationTEC.dairyController,
                text: "ألبان"),
            MyCheckBox(
                controller: ClientRegistrationTEC.proteinController,
                text: "بروتينات"),
            MyCheckBox(
                controller: ClientRegistrationTEC.carbohydratesController,
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
                controller: ClientRegistrationTEC.sportsController,
                text: 'ممارسة الرياضة'),
            MyCheckBox(
                controller: ClientRegistrationTEC.yoyoController,
                text: '(رجيم سابق) YOYO'),
          ],
        ),
      ],
    ),
  );
}
