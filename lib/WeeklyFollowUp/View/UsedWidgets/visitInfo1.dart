import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/VisitTEC.dart';

Widget visitInfo1() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
        "بيانات الزيارة",
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                spacing: 60,
                children: [
                  MyInputField(
                    myController: VisitTEC.visitDietController,
                    hint: "",
                    label: "اسم النظام",
                  ),
                  MyInputField(
                    myController: VisitTEC.visitWeightController,
                    hint: "",
                    label: "الوزن",
                  ),
                  MyInputField(
                    myController: VisitTEC.visitBMIController,
                    hint: "",
                    label: "مؤشر كتلة الجسم",
                  ),
                ],
              )
            ],
          ),
        )),
  );
}
