import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsPageTEC.dart';

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
                controller: UpdateClientDetailsPageTEC.backController,
                text: "ظهر"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.breastController,
                text: "صدر"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.armsController,
                text: "ذراعات"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.thighsController,
                text: "أفخاذ"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.waistController,
                text: "وسط"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.buttocksController,
                text: "مقعدة"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.abdomenController,
                text: "بطن"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController:
                    UpdateClientDetailsPageTEC.dailyCaloriesController,
                hint: '',
                label: "السعرات اليومية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.maxCaloriesController,
                hint: '',
                label: "أقصي سعرات",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.bmrController,
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
