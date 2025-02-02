import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../UsedWidgets/ActivityLevelDropdownMenu.dart';
import '../UsedWidgets/MyCard.dart';
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
              activityLevelController: activityLevelController,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "الطعام المفضل:",
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
                myController: othersPreferredFoodsController,
                hint: 'أخري',
                label: 'أخري',
              ),
            ),
            MyCheckBox(controller: fruitsController, text: "فاكهة"),
            MyCheckBox(controller: vegController, text: "خضار"),
            MyCheckBox(controller: dairyController, text: "ألبان"),
            MyCheckBox(controller: proteinController, text: "بروتينات"),
            MyCheckBox(
                controller: carbohydratesController, text: "كربوهايدرات"),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: WrapAlignment.end,
          children: [
            MyCheckBox(controller: sportsController, text: 'ممارسة الرياضة'),
            MyCheckBox(controller: yoyoController, text: '(رجيم سابق) YOYO'),
          ],
        ),
      ],
    ),
  );
}
