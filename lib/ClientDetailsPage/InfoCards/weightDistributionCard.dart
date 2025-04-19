import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/StaticCheckBox.dart';

import '../../Core/Model/Classes/WeightAreas.dart';
import '../UsedWidgets/detailsCard.dart';
Widget weightDistributionCard(WeightAreas? weightAreas) {
  return detailsCard(
    'توزيع الوزن',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: weightAreas != null
          ? _buildWeightDistributionRows(weightAreas)
          : [
              const Center(child: Text('لا توجد بيانات توزيع الوزن'))
            ],
    ),
  );
}

List<Widget> _buildWeightDistributionRows(WeightAreas weightAreas) {
  return [
    Wrap(
      textDirection: TextDirection.rtl,
      spacing: 50,
      runSpacing: 20,
      children: [
        staticCheckBox('البطن', weightAreas.mAbdomen),
        staticCheckBox('مقعدة', weightAreas.mButtocks),
        staticCheckBox('الوسط', weightAreas.mWaist),
        staticCheckBox('الفخذين', weightAreas.mThighs),
        staticCheckBox('الذراعين', weightAreas.mArms),
        staticCheckBox('الصدر', weightAreas.mBreast),
        staticCheckBox('الظهر', weightAreas.mBack),
      ],
    ),
  ];
}