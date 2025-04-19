import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/ActivityLevelDropdownMenu.dart';
import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/ClientRegistrationTEC.dart';

Widget dietPreferencesCard() {
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
                  ClientRegistrationTEC.dietController,
                  hint: '',
                  label: 'النظام الغذائي',
                ),
              ),
            ),
            const SizedBox(width: 30),
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
                    ClientRegistrationTEC.otherPreferredFoodsController,
                hint: '',
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
