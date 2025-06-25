import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/SingleFollowUpTEC.dart';

Widget singleFollowUpInfo2() {
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
              Expanded(
                  child: MyInputField(
                      myController: SingleFollowUpTEC.singleFollowUpNotesController,
                      hint: '',
                      label: "ملاحظات"))
            ],
          ),
        )),
  );
}
