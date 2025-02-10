import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

Widget weightHistoryCard() {
  return myCard(
    'سجل الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: optimalWeightController,
                hint: '',
                label: "وزن مثالي",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: maxWeightController,
                hint: '',
                label: "أقصي وزن",
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "الأوزان الثابتة السابقة:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyInputField(
                myController:
                    platControllers[platControllers.length - 6 - index],
                hint: "",
                label: "الوزن الثابت ${platControllers.length - 5 - index}",
              ),
            );
          }),
        ),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyInputField(
                myController:
                    platControllers[platControllers.length - 1 - index],
                hint: "",
                label: "الوزن الثابت ${platControllers.length - index}",
              ),
            );
          }),
        ),
      ],
    ),
  );
}
