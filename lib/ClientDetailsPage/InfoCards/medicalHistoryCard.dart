import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Disease.dart';
import '../../NewClientRegistration/View/UsedWidgets/MyCard.dart';
import 'infoRow.dart';

Widget medicalHistoryCard(Disease? myDisease) {
  return myCard(
    'Medical History',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: myDisease != null
          ? _buildMedicalHistoryRows(myDisease)
          : [const Center(child: Text('No medical history available'))],
    ),
  );
}

List<Widget> _buildMedicalHistoryRows(Disease myDisease) {
  return [
    _buildInfoRow('Hypertension', myDisease.mHypertension),
    _buildInfoRow('Hypotension', myDisease.mHypotension),
    _buildInfoRow('Vascular', myDisease.mVascular),
    _buildInfoRow('Anemia', myDisease.mAnemia),
    infoRow('Other Heart', myDisease.mOtherHeart),
    _buildInfoRow('Colon', myDisease.mColon),
    _buildInfoRow('Constipation', myDisease.mConstipation),
    _buildInfoRow('Family History DM', myDisease.mFamilyHistoryDM),
    _buildInfoRow('Previous OB Med', myDisease.mPreviousOBMed),
    _buildInfoRow('Previous OB Operations', myDisease.mPreviousOBOperations),
    infoRow('Renal', myDisease.mRenal),
    infoRow('Liver', myDisease.mLiver),
    infoRow('GIT', myDisease.mGit),
    infoRow('Endocrine', myDisease.mEndocrine),
    infoRow('Rheumatic', myDisease.mRheumatic),
    infoRow('Allergies', myDisease.mAllergies),
    infoRow('Neuro', myDisease.mNeuro),
    infoRow('Psychiatric', myDisease.mPsychiatric),
    infoRow('Others', myDisease.mOthers),
    infoRow('Hormonal', myDisease.mHormonal),
  ];
}

Widget _buildInfoRow(String label, bool value) {
  return infoRow(label, value ? 'Yes' : 'No');
}
