import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/SingleFollowUpTEC.dart';

Widget newSingleFollowUp1() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
        "بيانات الزيارة",
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: [
              // Row 1: Diet and Weight
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      myController: SingleFollowUpTEC.singleFollowUpDietController,
                      hint: "",
                      label: "اسم النظام",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MyInputField(
                      myController: SingleFollowUpTEC.singleFollowUpWeightController,
                      hint: "",
                      label: "الوزن",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Row 2: Notes (full width)
              MyInputField(
                myController: SingleFollowUpTEC.singleFollowUpNotesController,
                hint: '',
                label: "ملاحظات",
              ),
            ],
          ),
        )),
  );
}
