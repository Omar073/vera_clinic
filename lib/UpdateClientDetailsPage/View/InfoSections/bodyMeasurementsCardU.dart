import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsPageTEC.dart';

Widget bodyMeasurementsCardU() {
  return myCard(
    'القياسات الجسمية',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.heightController,
                hint: "أدخل الطول (سم)",
                label: "الطول",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.weightController,
                hint: "أدخل الوزن (كجم)",
                label: "الوزن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.bmiController,
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
                myController: UpdateClientDetailsPageTEC.waterController,
                hint: '',
                label: "الماء",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.pbfController,
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
