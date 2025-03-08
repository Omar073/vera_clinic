import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/WeightAreas.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

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
    _buildInfoRow('البطن', weightAreas.mAbdomen),
    _buildInfoRow('مقعدة', weightAreas.mButtocks),
    _buildInfoRow('الوسط', weightAreas.mWaist),
    _buildInfoRow('الفخذين', weightAreas.mThighs),
    _buildInfoRow('الذراعين', weightAreas.mArms),
    _buildInfoRow('الصدر', weightAreas.mBreast),
    _buildInfoRow('الظهر', weightAreas.mBack),
  ];
}

Widget _buildInfoRow(String label, bool value) {
  return infoRow(label, value ? 'نعم' : 'لا');
}