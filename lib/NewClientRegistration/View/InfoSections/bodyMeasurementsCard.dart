import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

Widget bodyMeasurementsCard() {
  return myCard(
    'القياسات الجسمية',
    Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.weightController,
                hint: "الوزن (كغ)",
                label: "الوزن",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.heightController,
                hint: 'الطول (سم)',
                label: 'الطول',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.waterController,
                hint: '',
                label: "الماء",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.pbfController,
                hint: "PBF ",
                label: "نسبة الدهن",
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
