import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/Reusable widgets/myCard.dart';

Widget weightHistoryCard(Client? client) {
  return myCard(
    'تاريخ الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          textDirection: TextDirection.rtl,
          children: List.generate(client?.Plat.length ?? 0, (index) {
            if (client?.Plat[index] != null && client?.Plat[index] != 0) {
              return MyTextBox(
                title: 'الوزن الثابت ${index + 1}',
                value: '${client?.Plat[index] ?? 0}',
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ],
    ),
  );
}
