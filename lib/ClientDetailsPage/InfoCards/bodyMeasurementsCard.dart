import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

Widget bodyMeasurementsCard(
    Client? client, ClientMonthlyFollowUp? monthlyFollowUp) {
  return detailsCard(
    'قياسات الجسم',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (monthlyFollowUp != null) ...[
          infoRow('الطول', '${client?.mHeight ?? 0} cm'),
          infoRow('الوزن', '${client?.mWeight ?? 0} kg'),
          infoRow('مؤشر كتلة الجسم', '${monthlyFollowUp.mBMI}'),
          infoRow('نسبة الدهون في الجسم', '${monthlyFollowUp.mPBF} %'),
          infoRow('الماء', '${monthlyFollowUp.mWater}'),
          infoRow('الوزن الأقصى', '${monthlyFollowUp.mMaxWeight} kg'),
          infoRow('الوزن المثالي', '${monthlyFollowUp.mOptimalWeight} kg'),
          infoRow('معدل الأيض الأساسي', '${monthlyFollowUp.mBMR}'),
          infoRow('السعرات الحرارية القصوى', '${monthlyFollowUp.mMaxCalories}'),
          infoRow('السعرات الحرارية اليومية', '${monthlyFollowUp.mDailyCalories}'),
        ] else ...[
          const Center(child: Text('لا توجد بيانات قياسات الجسم')),
        ]
      ],
    ),
  );
}