class Disease {
  String _mDiseaseId;
  String _mClientPhoneNum;

  // Heart
  bool _mHypertension;
  bool _mHypotension;
  bool _mVascular = false; //todo: kammel
  bool _mAnemia;

  String _mRenal;
  String _mLiver;

  String _mGit;
  bool _mColon;
  bool _mConstipation;

  String _mEndocrine;
  String _mRheumatic;
  String _mAllergies;
  String _mNeuro;
  String _mPsychiatric;
  String _mOthers;
  String _mHormonal;

  bool _mFamilyHistoryDM;
  bool _mPreviousOBMed;
  bool _mPreviousOBOperations;

  Disease(
    this._mDiseaseId,
    this._mClientPhoneNum,
    this._mHypertension,
    this._mHypotension,
    this._mVascular,
    this._mAnemia,
    this._mColon,
    this._mConstipation,
    this._mFamilyHistoryDM,
    this._mPreviousOBMed,
    this._mPreviousOBOperations,
    this._mRenal,
    this._mLiver,
    this._mGit,
    this._mEndocrine,
    this._mRheumatic,
    this._mAllergies,
    this._mNeuro,
    this._mPsychiatric,
    this._mOthers,
    this._mHormonal,
  );

// Getters
  String get diseaseId => _mDiseaseId;
  String get clientPhoneNum => _mClientPhoneNum;
  bool get hypertension => _mHypertension;
  bool get hypotension => _mHypotension;
  bool get vascular => _mVascular;
  bool get anemia => _mAnemia;
  bool get colon => _mColon;
  bool get constipation => _mConstipation;
  bool get familyHistoryDM => _mFamilyHistoryDM;
  bool get previousOBMed => _mPreviousOBMed;
  bool get previousOBOperations => _mPreviousOBOperations;
  String get renal => _mRenal;
  String get liver => _mLiver;
  String get git => _mGit;
  String get endocrine => _mEndocrine;
  String get rheumatic => _mRheumatic;
  String get allergies => _mAllergies;
  String get neuro => _mNeuro;
  String get psychiatric => _mPsychiatric;
  String get others => _mOthers;
  String get hormonal => _mHormonal;

// Setters
  set diseaseId(String diseaseId) {
    _mDiseaseId = diseaseId;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
  }

  set hypertension(bool hypertension) {
    _mHypertension = hypertension;
  }

  set hypotension(bool hypotension) {
    _mHypotension = hypotension;
  }

  set vascular(bool vascular) {
    _mVascular = vascular;
  }

  set anemia(bool anemia) {
    _mAnemia = anemia;
  }

  set colon(bool colon) {
    _mColon = colon;
  }

  set constipation(bool constipation) {
    _mConstipation = constipation;
  }

  set familyHistoryDM(bool familyHistoryDM) {
    _mFamilyHistoryDM = familyHistoryDM;
  }

  set previousOBMed(bool previousOBMed) {
    _mPreviousOBMed = previousOBMed;
  }

  set previousOBOperations(bool previousOBOperations) {
    _mPreviousOBOperations = previousOBOperations;
  }

  set renal(String renal) {
    _mRenal = renal;
  }

  set liver(String liver) {
    _mLiver = liver;
  }

  set git(String git) {
    _mGit = git;
  }

  set endocrine(String endocrine) {
    _mEndocrine = endocrine;
  }

  set rheumatic(String rheumatic) {
    _mRheumatic = rheumatic;
  }

  set allergies(String allergies) {
    _mAllergies = allergies;
  }

  set neuro(String neuro) {
    _mNeuro = neuro;
  }

  set psychiatric(String psychiatric) {
    _mPsychiatric = psychiatric;
  }

  set others(String others) {
    _mOthers = others;
  }

  set hormonal(String hormonal) {
    _mHormonal = hormonal;
  }

  factory Disease.fromFirestore(Map<String, dynamic> data) {
    return Disease(
      data['diseaseId'] as String,
      data['clientPhoneNum'] as String,
      data['hypertension'] as bool,
      data['hypotension'] as bool,
      data['vascular'] as bool,
      data['anemia'] as bool,
      data['colon'] as bool,
      data['constipation'] as bool,
      data['familyHistoryDM'] as bool,
      data['previousOBMed'] as bool,
      data['previousOBOperations'] as bool,
      data['renal'] as String,
      data['liver'] as String,
      data['git'] as String,
      data['endocrine'] as String,
      data['rheumatic'] as String,
      data['allergies'] as String,
      data['neuro'] as String,
      data['psychiatric'] as String,
      data['others'] as String,
      data['hormonal'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'diseaseId': _mDiseaseId,
      'clientPhoneNum': _mClientPhoneNum,
      'hypertension': _mHypertension,
      'hypotension': _mHypotension,
      'vascular': _mVascular,
      'anemia': _mAnemia,
      'colon': _mColon,
      'constipation': _mConstipation,
      'familyHistoryDM': _mFamilyHistoryDM,
      'previousOBMed': _mPreviousOBMed,
      'previousOBOperations': _mPreviousOBOperations,
      'renal': _mRenal,
      'liver': _mLiver,
      'git': _mGit,
      'endocrine': _mEndocrine,
      'rheumatic': _mRheumatic,
      'allergies': _mAllergies,
      'neuro': _mNeuro,
      'psychiatric': _mPsychiatric,
      'others': _mOthers,
      'hormonal': _mHormonal,
    };
  }
}
