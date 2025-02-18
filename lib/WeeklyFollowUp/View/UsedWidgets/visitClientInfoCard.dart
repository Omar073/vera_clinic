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
                  Text("${client.mDiet ?? 'No Diet'} :إسم النظام الحالي ",
                      style: const TextStyle(fontSize: 20)),
                  Text("الوزن: ${client.mWeight ?? 'No weight'}",
                      style: const TextStyle(fontSize: 20)),
                  Text(
                    'السن: ${getAge(client.mBirthdate) ?? 'No age'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${client.mName ?? 'No name'} :الإسم',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        )),
  );
}
