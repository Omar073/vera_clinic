import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Core/Model/Classes/Disease.dart';
import '../../Core/View/Reusable widgets/StaticCheckBox.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../../Core/View/Reusable widgets/MyTextBox.dart';

Widget medicalHistoryCard(Disease? myDisease) {
  return myCard(
    'التاريخ الطبي',
    myDisease != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                spacing: 50,
                runSpacing: 10,
                alignment: WrapAlignment.end,
                children: [
                  staticCheckBox('Hypertension', myDisease.mHypertension),
                  staticCheckBox('Hypotension', myDisease.mHypotension),
                  staticCheckBox('Vascular', myDisease.mVascular),
                  staticCheckBox('Anemia', myDisease.mAnemia),
                  staticCheckBox('القولون', myDisease.mColon),
                  staticCheckBox('الإمساك', myDisease.mConstipation),
                  staticCheckBox(
                      'تاريخ مرض السكري', myDisease.mFamilyHistoryDM),
                  staticCheckBox('أدوية سمنة سابقة', myDisease.mPreviousOBMed),
                  staticCheckBox(
                      'عمليات سمنة سابقة', myDisease.mPreviousOBOperations),
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.end,
                children: [
                  MyTextBox(
                      title: 'أمراض القلب الأخرى',
                      value: myDisease.mOtherHeart),
                  MyTextBox(title: 'الكلى', value: myDisease.mRenal),
                  MyTextBox(title: 'الكبد', value: myDisease.mLiver),
                  MyTextBox(title: 'الجهاز الهضمي', value: myDisease.mGit),
                  MyTextBox(title: 'الغدد الصماء', value: myDisease.mEndocrine),
                  MyTextBox(title: 'الروماتيزم', value: myDisease.mRheumatic),
                  MyTextBox(title: 'الحساسية', value: myDisease.mAllergies),
                  MyTextBox(title: 'الأعصاب', value: myDisease.mNeuro),
                  MyTextBox(
                      title: 'الأمراض النفسية', value: myDisease.mPsychiatric),
                  MyTextBox(title: 'الهرمونات', value: myDisease.mHormonal),
                  MyTextBox(title: 'أخرى', value: myDisease.mOtherDiseases),
                ],
              ),
            ],
          )
        : const Center(child: Text('لا يوجد تاريخ طبي متاح')),
  );
}
