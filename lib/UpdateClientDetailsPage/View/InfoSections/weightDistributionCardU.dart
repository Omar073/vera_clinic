import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsTEC.dart';

Widget weightDistributionCardU() {
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
            MyCheckBox(
                controller: UpdateClientDetailsTEC.backController,
                text: "ظهر"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.breastController,
                text: "صدر"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.armsController,
                text: "ذراعات"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.thighsController,
                text: "أفخاذ"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.waistController,
                text: "وسط"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.buttocksController,
                text: "مقعدة"),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.abdomenController,
                text: "بطن"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController:
                    UpdateClientDetailsTEC.dailyCaloriesController,
                hint: '',
                label: "السعرات اليومية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.maxCaloriesController,
                hint: '',
                label: "أقصي سعرات",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                label: "معدل الحرق الأساسي",
                myController: UpdateClientDetailsTEC.bmrController,
                hint: 'BMR',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
