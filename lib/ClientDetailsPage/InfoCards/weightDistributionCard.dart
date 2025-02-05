import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/WeightAreas.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import 'infoRow.dart';

Widget weightDistributionCard(WeightAreas? weightAreas) {
  return myCard(
    'Weight Distribution',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: weightAreas != null
          ? _buildWeightDistributionRows(weightAreas)
          : [const Center(child: Text('No weight distribution data available'))],
    ),
  );
}

List<Widget> _buildWeightDistributionRows(WeightAreas weightAreas) {
  return [
    _buildInfoRow('Abdomen', weightAreas.mAbdomen),
    _buildInfoRow('Buttocks', weightAreas.mButtocks),
    _buildInfoRow('Waist', weightAreas.mWaist),
    _buildInfoRow('Thighs', weightAreas.mThighs),
    _buildInfoRow('Arms', weightAreas.mArms),
    _buildInfoRow('Breast', weightAreas.mBreast),
    _buildInfoRow('Back', weightAreas.mBack),
  ];
}

Widget _buildInfoRow(String label, bool value) {
  return infoRow(label, value ? 'Yes' : 'No');
}