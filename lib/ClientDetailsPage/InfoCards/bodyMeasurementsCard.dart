import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../NewClientRegistration/View/UsedWidgets/MyCard.dart';
import 'infoRow.dart';

Widget bodyMeasurementsCard(
    Client? client, ClientMonthlyFollowUp? monthlyFollowUp) {
  return myCard(
    'Body Measurements',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (monthlyFollowUp != null) ...[
          infoRow('Height', '${client?.mHeight ?? 0} cm'),
          infoRow('Weight', '${client?.mWeight ?? 0} kg'),
          infoRow('BMI', '${monthlyFollowUp.mBMI}'),
          infoRow('PBF', '${monthlyFollowUp.mPBF} %'),
          infoRow('Water', '${monthlyFollowUp.mWater}'),
          infoRow('Max Weight', '${monthlyFollowUp.mMaxWeight} kg'),
          infoRow(
              'Optimal Weight', '${monthlyFollowUp.mOptimalWeight} kg'),
          infoRow('BMR', '${monthlyFollowUp.mBMR}'),
          infoRow('Max Calories', '${monthlyFollowUp.mMaxCalories}'),
          infoRow(
              'Daily Calories', '${monthlyFollowUp.mDailyCalories}'),
        ] else ...[
          const Center(child: Text('No body measurements data available')),
        ]
      ],
    ),
  );
}
