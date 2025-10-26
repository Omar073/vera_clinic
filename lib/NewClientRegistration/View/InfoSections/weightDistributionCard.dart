import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

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
      ],
    ),
  );
}
