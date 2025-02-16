import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/NewClientRegistrationTEC.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

Widget bodyMeasurementsCard() {
  return myCard(
    'القياسات الجسمية',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.heightController,
                hint: "أدخل الطول (سم)",
                label: "الطول",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.weightController,
                hint: "أدخل الوزن (كجم)",
                label: "الوزن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.bmiController,
                hint: "BMI ",
                label: "مؤشر كتلة الجسم",
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
            const SizedBox(width: 16),
          ],
        ),
      ],
    ),
  );
}
