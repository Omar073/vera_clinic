import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/Model/Classes/Disease.dart';
import '../../Core/View/Reusable widgets/MyTextBox.dart';
import '../../Core/View/Reusable widgets/StaticCheckBox.dart';
import '../../Core/View/Reusable widgets/myCard.dart';

Widget medicalHistoryCard(Disease? myDisease) {
  return myCard(
    'التاريخ الطبي',
    myDisease != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                ":أمراض القلب والأوعية الدموية",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 50,
                runSpacing: 10,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  staticCheckBox('Hypertension', myDisease.mHypertension),
                  staticCheckBox('Hypotension', myDisease.mHypotension),
                  staticCheckBox('Vascular', myDisease.mVascular),
                  staticCheckBox('Anemia', myDisease.mAnemia),
                  MyTextBox(
                      title: 'أمراض القلب الأخرى',
                      value: myDisease.mOtherHeart),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                ":أمراض الجهاز الهضمي",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  staticCheckBox('القولون', myDisease.mColon),
                  staticCheckBox('الإمساك', myDisease.mConstipation),
                  MyTextBox(
                      title: 'أمراض الجهاز الهضمي الأخري',
                      value: myDisease.mGit),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                ":معلومات طبية إضافية",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  MyTextBox(title: 'الغدد الصماء', value: myDisease.mEndocrine),
                  MyTextBox(title: 'الروماتيزم', value: myDisease.mRheumatic),
                  MyTextBox(title: 'الكلى', value: myDisease.mRenal),
                  MyTextBox(title: 'الكبد', value: myDisease.mLiver),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MyTextBox(title: 'الحساسية', value: myDisease.mAllergies),
                  MyTextBox(title: 'الأعصاب', value: myDisease.mNeuro),
                  MyTextBox(
                      title: 'الأمراض النفسية', value: myDisease.mPsychiatric),
                  MyTextBox(title: 'الهرمونات', value: myDisease.mHormonal),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  staticCheckBox('أدوية سمنة سابقة', myDisease.mPreviousOBMed),
                  staticCheckBox(
                      'عمليات سمنة سابقة', myDisease.mPreviousOBOperations),
                  staticCheckBox(
                      'تاريخ مرض السكري', myDisease.mFamilyHistoryDM),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: MyTextBox(
                        title: 'أمراض أخرى', value: myDisease.mOtherDiseases),
                  ),
                ],
              ),
            ],
          )
        : const Center(child: Text('لا يوجد تاريخ طبي متاح')),
  );
}
