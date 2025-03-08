import 'package:flutter/cupertino.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UtilityFunctions.dart';

Widget visitClientInfoCard(Client client) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: myCard(
        //todo: extract
        "متابعة اسبوعية",
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                spacing: 60,
                children: [
                  Text("${client.mDiet ?? 'لا يوجد نظام غذائي'} :إسم النظام الحالي ",
                      style: const TextStyle(fontSize: 20)),
                  Text("الوزن: ${client.mWeight ?? 'لا يوجد وزن'}",
                      style: const TextStyle(fontSize: 20)),
                  Text(
                    'السن: ${getAge(client.mBirthdate) ?? 'لا يوجد سن'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${client.mName ?? 'لا يوجد اسم'} :الإسم',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        )),
  );
}
