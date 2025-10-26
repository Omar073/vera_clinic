import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsTEC.dart';

Widget weightHistoryCardU() {
  return myCard(
    'سجل الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 24),
        const Text(
          ":الأوزان الثابتة السابقة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.start,
          textDirection: TextDirection.rtl,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyInputField(
                myController: UpdateClientDetailsTEC.platControllers[index],
                hint: "",
                label: "الوزن الثابت ${index + 1}",
              ),
            );
          }),
        ),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.start,
          textDirection: TextDirection.rtl,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyInputField(
                myController: UpdateClientDetailsTEC.platControllers[index + 5],
                hint: "",
                label: "الوزن الثابت ${index + 6}",
              ),
            );
          }),
        ),
      ],
    ),
  );
}
