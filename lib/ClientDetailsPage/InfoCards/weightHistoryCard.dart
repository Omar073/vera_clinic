import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import 'infoRow.dart';

Widget weightHistoryCard(Client? client) {
  return myCard(
    'Weight History',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(client?.Plat.length ?? 0, (index) {
        return infoRow(
            'Stable Weight ${index + 1}', '${client?.Plat[index] ?? 0} kg');
      }),
    ),
  );
}
