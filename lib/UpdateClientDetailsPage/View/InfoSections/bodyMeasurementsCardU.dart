import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsTEC.dart';

Widget bodyMeasurementsCardU() {
  return myCard(
    'القياسات الجسمية',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.heightController,
                hint: "أدخل الطول (سم)",
                label: "الطول",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.weightController,
                hint: "أدخل الوزن (كجم)",
                label: "الوزن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.muscleMassController,
                hint: "كتلة العضلات",
                label: "كتلة العضلات",
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.waterController,
                hint: '',
                label: "الماء",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.pbfController,
                hint: "PBF ",
                label: "نسبة الدهن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.bmrController,
                hint: "معدل الحرق الأساسي",
                label: "معدل الحرق الأساسي",
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.maxWeightController,
                hint: '',
                label: "أقصي وزن",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.optimalWeightController,
                hint: '',
                label: "وزن مثالي",
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
                myController: UpdateClientDetailsTEC.dailyCaloriesController,
                hint: '',
                label: "السعرات اليومية",
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
