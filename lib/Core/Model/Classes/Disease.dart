import 'package:flutter/cupertino.dart';

class Disease {
  late String mDiseaseId;
  String? mClientId;

  // Heart
  bool mHypertension = false;
  bool mHypotension = false;
  bool mVascular = false;
  bool mAnemia = false;
  String mOtherHeart = '';

  String mRenal = '';
  String mLiver = '';

  String mGit = '';
  bool mColon = false;
  bool mConstipation = false;

  String mEndocrine = '';
  String mRheumatic = '';
  String mAllergies = '';
  String mNeuro = '';
  String mPsychiatric = '';
  String mOtherDiseases = '';
  String mHormonal = '';

  bool mFamilyHistoryDM = false;
  bool mPreviousOBMed = false;
  bool mPreviousOBOperations = false;

  Disease({
    required String diseaseId,
    required String? clientId,
    required bool hypertension,
    required bool hypotension,
    required bool vascular,
    required bool anemia,
    required String otherHeart,
    required bool colon,
    required bool constipation,
    required bool familyHistoryDM,
    required bool previousOBMed,
    required bool previousOBOperations,
    required String renal,
    required String liver,
    required String git,
    required String endocrine,
    required String rheumatic,
    required String allergies,
    required String neuro,
    required String psychiatric,
    required String otherDiseases,
    required String hormonal,
  })  : mDiseaseId = diseaseId,
        mClientId = clientId,
        mHypertension = hypertension,
        mHypotension = hypotension,
        mVascular = vascular,
        mAnemia = anemia,
        mOtherHeart = otherHeart,
        mColon = colon,
        mConstipation = constipation,
        mFamilyHistoryDM = familyHistoryDM,
        mPreviousOBMed = previousOBMed,
        mPreviousOBOperations = previousOBOperations,
        mRenal = renal,
        mLiver = liver,
        mGit = git,
        mEndocrine = endocrine,
        mRheumatic = rheumatic,
        mAllergies = allergies,
        mNeuro = neuro,
        mPsychiatric = psychiatric,
        mOtherDiseases = otherDiseases,
        mHormonal = hormonal;


  void printDisease() {
    debugPrint('\n\t\t<<Disease>>\n'
        'Disease ID: $mDiseaseId, Client ID: $mClientId, Hypertension: '
        '$mHypertension, Hypotension: $mHypotension, Vascular: $mVascular,'
        ' Anemia: $mAnemia, Other Heart: $mOtherHeart, Colon: $mColon, '
        'Constipation: $mConstipation, Family History DM: $mFamilyHistoryDM,'
        ' Previous OB Med: $mPreviousOBMed, Previous OB Operations: '
        '$mPreviousOBOperations, Renal: $mRenal, Liver: $mLiver, GIT: $mGit,'
        ' Endocrine: $mEndocrine, Rheumatic: $mRheumatic, Allergies: '
        '$mAllergies, Neuro: $mNeuro, Psychiatric: $mPsychiatric, otherDiseases: '
        '$mOtherDiseases, Hormonal: $mHormonal');
  }

  factory Disease.fromFirestore(Map<String, dynamic> data) {
    return Disease(
      diseaseId: data['diseaseId'] as String? ?? '',
      clientId: data['clientId'] as String?,
      hypertension: data['hypertension'] as bool,
      hypotension: data['hypotension'] as bool,
      vascular: data['vascular'] as bool,
      anemia: data['anemia'] as bool,
      otherHeart: data['otherHeart'] as String? ?? '',
      colon: data['colon'] as bool,
      constipation: data['constipation'] as bool,
      familyHistoryDM: data['familyHistoryDM'] as bool,
      previousOBMed: data['previousOBMed'] as bool,
      previousOBOperations: data['previousOBOperations'] as bool,
      renal: data['renal'] as String? ?? '',
      liver: data['liver'] as String? ?? '',
      git: data['git'] as String? ?? '',
      endocrine: data['endocrine'] as String? ?? '',
      rheumatic: data['rheumatic'] as String? ?? '',
      allergies: data['allergies'] as String? ?? '',
      neuro: data['neuro'] as String? ?? '',
      psychiatric: data['psychiatric'] as String? ?? '',
      otherDiseases: data['otherDiseases'] as String? ?? '',
      hormonal: data['hormonal'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'diseaseId': mDiseaseId,
      'clientId': mClientId,
      'hypertension': mHypertension,
      'hypotension': mHypotension,
      'vascular': mVascular,
      'anemia': mAnemia,
      'otherHeart': mOtherHeart,
      'colon': mColon,
      'constipation': mConstipation,
      'familyHistoryDM': mFamilyHistoryDM,
      'previousOBMed': mPreviousOBMed,
      'previousOBOperations': mPreviousOBOperations,
      'renal': mRenal,
      'liver': mLiver,
      'git': mGit,
      'endocrine': mEndocrine,
      'rheumatic': mRheumatic,
      'allergies': mAllergies,
      'neuro': mNeuro,
      'psychiatric': mPsychiatric,
      'otherDiseases': mOtherDiseases,
      'hormonal': mHormonal,
    };
  }
}
