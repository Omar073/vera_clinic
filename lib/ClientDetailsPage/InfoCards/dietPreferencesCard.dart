import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/ClientConstantInfo.dart';
import '../../Core/Model/Classes/PreferredFoods.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import 'infoRow.dart';

Widget dietPreferencesCard(String diet, PreferredFoods? preferredFoods,
    ClientConstantInfo? clientConstantInfo) {
  return myCard(
    'Diet Preferences',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow('Diet', diet),
        if (preferredFoods != null)
          ..._buildPreferredFoodsRows(preferredFoods)
        else
          const Center(child: Text('No preferred foods data available')),
        if (clientConstantInfo != null)
          ..._buildClientConstantInfoRows(clientConstantInfo)
        else
          const Center(child: Text('No client constant info available')),
      ],
    ),
  );
}

List<Widget> _buildPreferredFoodsRows(PreferredFoods preferredFoods) {
  return [
    infoRow('carbohydrates', preferredFoods.mCarbohydrates ? 'Yes' : 'No'),
    infoRow('Proteins', preferredFoods.mProtein ? 'Yes' : 'No'),
    infoRow('Dairy', preferredFoods.mDairy ? 'Yes' : 'No'),
    infoRow('Vegetables', preferredFoods.mVeg ? 'Yes' : 'No'),
    infoRow('Fruits', preferredFoods.mFruits ? 'Yes' : 'No'),
    infoRow('Other', preferredFoods.mOthers),
  ];
}

List<Widget> _buildClientConstantInfoRows(ClientConstantInfo clientConstantInfo) {
  return [
    infoRow('Sports', clientConstantInfo.mSports ? 'Yes' : 'No'),
    infoRow('(رجيم سابق) YOYO', clientConstantInfo.mYOYO ? 'Yes' : 'No'),
  ];
}