import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/SingleFollowUpTEC.dart';

Widget singleFollowUpInfo1() {
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
                myController: SingleFollowUpTEC.singleFollowUpDietController,
                hint: "",
                label: "اسم النظام",
                // maxLines: 2,
              ),
              MyInputField(
                myController: SingleFollowUpTEC.singleFollowUpWeightController,
                hint: "",
                label: "الوزن",
              ),
              MyInputField(
                myController: SingleFollowUpTEC.singleFollowUpBMIController,
                hint: "",
                label: "مؤشر كتلة الجسم",
              ),
            ],
          ),
        )),
  );
}
