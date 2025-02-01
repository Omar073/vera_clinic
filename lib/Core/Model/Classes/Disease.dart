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
  String mOthers = '';
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
    required String others,
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
        mOthers = others,
        mHormonal = hormonal;

// Setters
  set diseaseId(String diseaseId) {
    mDiseaseId = diseaseId;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set hypertension(bool hypertension) {
    mHypertension = hypertension;
  }

  set hypotension(bool hypotension) {
    mHypotension = hypotension;
  }

  set vascular(bool vascular) {
    mVascular = vascular;
  }

  set anemia(bool anemia) {
    mAnemia = anemia;
  }

  set otherHeart(String otherHeart) {
    mOtherHeart = otherHeart;
  }

  set colon(bool colon) {
    mColon = colon;
  }

  set constipation(bool constipation) {
    mConstipation = constipation;
  }

  set familyHistoryDM(bool familyHistoryDM) {
    mFamilyHistoryDM = familyHistoryDM;
  }

  set previousOBMed(bool previousOBMed) {
    mPreviousOBMed = previousOBMed;
  }

  set previousOBOperations(bool previousOBOperations) {
    mPreviousOBOperations = previousOBOperations;
  }

  set renal(String renal) {
    mRenal = renal;
  }

  set liver(String liver) {
    mLiver = liver;
  }

  set git(String git) {
    mGit = git;
  }

  set endocrine(String endocrine) {
    mEndocrine = endocrine;
  }

  set rheumatic(String rheumatic) {
    mRheumatic = rheumatic;
  }

  set allergies(String allergies) {
    mAllergies = allergies;
  }

  set neuro(String neuro) {
    mNeuro = neuro;
  }

  set psychiatric(String psychiatric) {
    mPsychiatric = psychiatric;
  }

  set others(String others) {
    mOthers = others;
  }

  set hormonal(String hormonal) {
    mHormonal = hormonal;
  }

  void printDisease() {
    debugPrint('\n\t\t<<Disease>>\n'
        'Disease ID: $mDiseaseId, Client ID: $mClientId, Hypertension: '
        '$mHypertension, Hypotension: $mHypotension, Vascular: $mVascular,'
        ' Anemia: $mAnemia, Other Heart: $mOtherHeart, Colon: $mColon, '
        'Constipation: $mConstipation, Family History DM: $mFamilyHistoryDM,'
        ' Previous OB Med: $mPreviousOBMed, Previous OB Operations: '
        '$mPreviousOBOperations, Renal: $mRenal, Liver: $mLiver, GIT: $mGit,'
        ' Endocrine: $mEndocrine, Rheumatic: $mRheumatic, Allergies: '
        '$mAllergies, Neuro: $mNeuro, Psychiatric: $mPsychiatric, Others: '
        '$mOthers, Hormonal: $mHormonal');
  }

  factory Disease.fromFirestore(Map<String, dynamic> data) {
    return Disease(
      diseaseId: data['diseaseId'] as String,
      clientId: data['clientId'] as String?,
      hypertension: data['hypertension'] as bool,
      hypotension: data['hypotension'] as bool,
      vascular: data['vascular'] as bool,
      anemia: data['anemia'] as bool,
      otherHeart: data['otherHeart'] as String,
      colon: data['colon'] as bool,
      constipation: data['constipation'] as bool,
      familyHistoryDM: data['familyHistoryDM'] as bool,
      previousOBMed: data['previousOBMed'] as bool,
      previousOBOperations: data['previousOBOperations'] as bool,
      renal: data['renal'] as String,
      liver: data['liver'] as String,
      git: data['git'] as String,
      endocrine: data['endocrine'] as String,
      rheumatic: data['rheumatic'] as String,
      allergies: data['allergies'] as String,
      neuro: data['neuro'] as String,
      psychiatric: data['psychiatric'] as String,
      others: data['others'] as String,
      hormonal: data['hormonal'] as String,
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
      'others': mOthers,
      'hormonal': mHormonal,
    };
  }
}
