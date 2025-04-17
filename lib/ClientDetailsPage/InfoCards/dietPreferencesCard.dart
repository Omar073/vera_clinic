import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/ClientConstantInfo.dart';
import '../../Core/Model/Classes/PreferredFoods.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

Widget dietPreferencesCard(String diet, PreferredFoods? preferredFoods,
    ClientConstantInfo? clientConstantInfo) {
  return detailsCard(
    'تفضيلات النظام الغذائي',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow('النظام الغذائي', diet),
        if (preferredFoods != null)
          ..._buildPreferredFoodsRows(preferredFoods)
        else
          const Center(child: Text('لا توجد بيانات الأطعمة المفضلة')),
        if (clientConstantInfo != null)
          ..._buildClientConstantInfoRows(clientConstantInfo)
        else
          const Center(child: Text('لا توجد بيانات ثابتة للعميل')),
      ],
    ),
  );
}

List<Widget> _buildPreferredFoodsRows(PreferredFoods preferredFoods) {
  return [
    infoRow('الكربوهيدرات', preferredFoods.mCarbohydrates ? 'نعم' : 'لا'),
    infoRow('البروتينات', preferredFoods.mProtein ? 'نعم' : 'لا'),
    infoRow('منتجات الألبان', preferredFoods.mDairy ? 'نعم' : 'لا'),
    infoRow('الخضروات', preferredFoods.mVeg ? 'نعم' : 'لا'),
    infoRow('الفواكه', preferredFoods.mFruits ? 'نعم' : 'لا'),
    infoRow('أخرى', preferredFoods.mOthers),
  ];
}

List<Widget> _buildClientConstantInfoRows(ClientConstantInfo clientConstantInfo) {
  return [
    infoRow('الرياضة', clientConstantInfo.mSports ? 'نعم' : 'لا'),
    infoRow('رجيم سابق (YOYO)', clientConstantInfo.mYOYO ? 'نعم' : 'لا'),
  ];
}