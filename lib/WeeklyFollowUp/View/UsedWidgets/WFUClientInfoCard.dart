import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UtilityFunctions.dart';

Widget WFUClientInfoCard(Client client, double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
      "متابعة اسبوعية",
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                spacing: 60,
                children: [
                  MyTextBox(
                      title: "إسم النظام الحالي",
                      value: client.mDiet ?? 'لا يوجد نظام غذائي'),
                  MyTextBox(
                      title: "الوزن",
                      value: client.mWeight?.toString() ?? 'لا يوجد وزن'),
                  MyTextBox(
                      title: "السن",
                      value: getAge(client.mBirthdate).isEmpty
                          ? 'لا يوجد سن'
                          : getAge(client.mBirthdate)),
                  MyTextBox(
                      title: "الإسم", value: client.mName ?? 'لا يوجد اسم'),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
