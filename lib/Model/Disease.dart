class Disease {
  // Heart
  bool _mHypertension;
  bool _mHypotension;
  bool _mVascular;
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
}}