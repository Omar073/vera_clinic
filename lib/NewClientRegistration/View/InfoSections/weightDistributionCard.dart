import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/NewClientRegistrationTEC.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
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
            MyCheckBox(
                controller: ClientRegistrationTEC.backController, text: "ظهر"),
            MyCheckBox(
                controller: ClientRegistrationTEC.breastController,
                text: "صدر"),
            MyCheckBox(
                controller: ClientRegistrationTEC.armsController,
                text: "ذراعات"),
            MyCheckBox(
                controller: ClientRegistrationTEC.thighsController,
                text: "أفخاذ"),
            MyCheckBox(
                controller: ClientRegistrationTEC.waistController, text: "وسط"),
            MyCheckBox(
                controller: ClientRegistrationTEC.buttocksController,
                text: "مقعدة"),
            MyCheckBox(
                controller: ClientRegistrationTEC.abdomenController,
                text: "بطن"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.dailyCaloriesController,
                hint: '',
                label: "السعرات اليومية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.maxCaloriesController,
                hint: '',
                label: "أقصي سعرات",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.bmrController,
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
