import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Disease.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../UsedWidgets/detailsCard.dart';
import '../UsedWidgets/infoRow.dart';

Widget medicalHistoryCard(Disease? myDisease) {
  return detailsCard(
    'التاريخ الطبي',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: myDisease != null
          ? _buildMedicalHistoryRows(myDisease)
          : [const Center(child: Text('لا يوجد تاريخ طبي متاح'))],
    ),
  );
}

List<Widget> _buildMedicalHistoryRows(Disease myDisease) {
  return [
    _buildInfoRow('Hypertension', myDisease.mHypertension),
    _buildInfoRow('Hypotension', myDisease.mHypotension),
    _buildInfoRow('Vascular', myDisease.mVascular),
    _buildInfoRow('Anemia', myDisease.mAnemia),
    infoRow('أمراض القلب الأخرى', myDisease.mOtherHeart),
    _buildInfoRow('القولون', myDisease.mColon),
    _buildInfoRow('الإمساك', myDisease.mConstipation),
    _buildInfoRow('تاريخ مرض السكري', myDisease.mFamilyHistoryDM),
    _buildInfoRow('أدوية سمنة سابقة', myDisease.mPreviousOBMed),
    _buildInfoRow('عمليات سمنة سابقة', myDisease.mPreviousOBOperations),
    infoRow('الكلى', myDisease.mRenal),
    infoRow('الكبد', myDisease.mLiver),
    infoRow('الجهاز الهضمي', myDisease.mGit),
    infoRow('الغدد الصماء', myDisease.mEndocrine),
    infoRow('الروماتيزم', myDisease.mRheumatic),
    infoRow('الحساسية', myDisease.mAllergies),
    infoRow('الأعصاب', myDisease.mNeuro),
    infoRow('الأمراض النفسية', myDisease.mPsychiatric),
    infoRow('الهرمونات', myDisease.mHormonal),
    infoRow('أخرى', myDisease.mOthers),
  ];
}

Widget _buildInfoRow(String label, bool value) {
  return infoRow(label, value ? 'نعم' : 'لا');
}
