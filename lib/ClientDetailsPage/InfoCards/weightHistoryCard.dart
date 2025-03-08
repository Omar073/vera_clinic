import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

Widget weightHistoryCard(Client? client) {
  return detailsCard(
    'تاريخ الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(client?.Plat.length ?? 0, (index) {
        return infoRow(
            'الوزن الثابت ${index + 1}', '${client?.Plat[index] ?? 0} kg');
      }),
    ),
  );
}