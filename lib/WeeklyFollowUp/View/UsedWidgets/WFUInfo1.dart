import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/WeeklyFollowUpTEC.dart';

Widget visitInfo1() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
        "بيانات الزيارة",
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Wrap(
            spacing: 60,
            alignment: WrapAlignment.start,
            children: [
              MyInputField(
                myController: WeeklyFollowUpTEC.visitDietController,
                hint: "",
                label: "اسم النظام",
                // maxLines: 2,
              ),
              MyInputField(
                myController: WeeklyFollowUpTEC.visitWeightController,
                hint: "",
                label: "الوزن",
              ),
              MyInputField(
                myController: WeeklyFollowUpTEC.visitBMIController,
                hint: "",
                label: "مؤشر كتلة الجسم",
              ),
            ],
          ),
        )),
  );
}
