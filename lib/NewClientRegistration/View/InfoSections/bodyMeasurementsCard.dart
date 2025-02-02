import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../UsedWidgets/MyCard.dart';

Widget bodyMeasurementsCard() {
  return myCard(
    'القياسات الجسمية',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: heightController,
                hint: "أدخل الطول (سم)",
                label: "الطول",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: weightController,
                hint: "أدخل الوزن (كجم)",
                label: "الوزن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: bmiController,
                hint: "BMI",
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
                myController: waterController,
                hint: '',
                label: "الماء",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: pbfController,
                hint: "PBF",
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
