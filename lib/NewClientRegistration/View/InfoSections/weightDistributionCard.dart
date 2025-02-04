import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../UsedWidgets/MyCard.dart';
import '../UsedWidgets/MyCheckBox.dart';

Widget weightDistributionCard() {
  return myCard(
    'مناطق توزيع الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: WrapAlignment.end,
          children: [
            MyCheckBox(controller: backController, text: "ظهر"),
            MyCheckBox(controller: breastController, text: "صدر"),
            MyCheckBox(controller: armsController, text: "ذراعات"),
            MyCheckBox(controller: thighsController, text: "أفخاذ"),
            MyCheckBox(controller: waistController, text: "وسط"),
            MyCheckBox(controller: buttocksController, text: "مقعدة"),
            MyCheckBox(controller: abdomenController, text: "بطن"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: dailyCaloriesController,
                hint: '',
                label: "السعرات اليومية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: maxCaloriesController,
                hint: '',
                label: "أقصي سعرات",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: bmrController,
                hint: '',
                label: "حد الحرق الأدنى",
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
