import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vera_clinic/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Model/Classes/PreferredFoods.dart';

import 'Disease.dart';
import 'Visit.dart';
import 'WeightAreas.dart';

enum SubscriptionType {
  none,
  newClient,
  singleVisit,
  weeklyVisit,
  monthlyVisit,
  afterBreak,
  cavSess,
  cavSess6,
  miso,
  punctureSess,
  punctureSess6,
  other
}

class Client {
  //TODO: add nullability
  String _mClientId;
  String _mName;
  String _mClientPhoneNum;
  String _mLastVisitId;
  DateTime _mBirthdate;
  String _mClientConstantInfoId;
  String _mDiseaseId;
  String _mDiet;
  List<double> _Plat = List.filled(10, 0); // Last 10 stable weights
  String _mClientMonthlyFollowUpId;
  String _mPreferredFoodsId;
  String _mWeightAreasId;
  String _mNotes;
  double _mHeight;
  double _mWeight;

  SubscriptionType _mSubscriptionType;

  Client(
      this._mClientId,
      this._mName,
      this._mClientPhoneNum,
      this._mLastVisitId,
      this._mBirthdate,
      this._mClientConstantInfoId,
      this._mDiseaseId,
      this._mDiet,
      this._Plat,
      this._mClientMonthlyFollowUpId,
      this._mPreferredFoodsId,
      this._mWeightAreasId,
      this._mNotes,
      this._mHeight,
      this._mWeight,
      this._mSubscriptionType);

  // Getters
  String get clientId => _mClientId;
  String get name => _mName;
  String get clientPhoneNum => _mClientPhoneNum;
  String get lastVisitId => _mLastVisitId;
  DateTime get birthdate => _mBirthdate;
  String get clientConstantInfoId => _mClientConstantInfoId;
  String get diseaseId => _mDiseaseId;
  String get diet => _mDiet;
  List<double> get plat => _Plat;
  String get clientMonthlyFollowUpId => _mClientMonthlyFollowUpId;
  String get preferredFoodsId => _mPreferredFoodsId;
  String get weightAreasId => _mWeightAreasId;
  String get notes => _mNotes;
  double get height => _mHeight;
  double get weight => _mWeight;
  SubscriptionType get subscriptionType => _mSubscriptionType;

// Setters
  set clientId(String clientId) {
    _mClientId = clientId;
  }

  set name(String name) {
    _mName = name;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
  }

  set lastVisitId(String lastVisitId) {
    _mLastVisitId = lastVisitId;
  }

  set birthdate(DateTime birthdate) {
    _mBirthdate = birthdate;
  }

  set clientConstantInfoId(String clientConstantInfoId) {
    _mClientConstantInfoId = clientConstantInfoId;
  }

  set diseaseId(String diseaseId) {
    _mDiseaseId = diseaseId;
  }

  set diet(String diet) {
    _mDiet = diet;
  }

  set plat(List<double> plat) {
    _Plat = plat;
  }

  set clientMonthlyFollowUpId(String clientMonthlyFollowUpId) {
    _mClientMonthlyFollowUpId = clientMonthlyFollowUpId;
  }

  set preferredFoodsId(String preferredFoodsId) {
    _mPreferredFoodsId = preferredFoodsId;
  }

  set weightAreasId(String weightAreasId) {
    _mWeightAreasId = weightAreasId;
  }

  set notes(String notes) {
    _mNotes = notes;
  }

  set height(double height) {
    _mHeight = height;
  }

  set weight(double weight) {
    _mWeight = weight;
  }

  set subscriptionType(SubscriptionType subscriptionType) {
    _mSubscriptionType = subscriptionType;
  }

  factory Client.fromFirestore(Map<String, dynamic> data) {
    // final data = doc.data() as Map<String, dynamic>;
    return Client(
      data['clientId'] as String, // _mClientId
      data['name'] as String, // _mName
      data['clientPhoneNum'] as String, // _mClientPhoneNum
      data['lastVisitId'] as String, // _mLastVisitId
      (data['birthDate'] as Timestamp).toDate(), // _mBirthdate
      data['clientConstantInfoId'] as String, // _mClientConstantInfoId
      data['diseaseId'] as String, // _mDiseaseId
      data['diet'] as String, // _mDiet
      (data['plat'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(), // _Plat
      data['clientMonthlyFollowUpId'] as String, // _mClientMonthlyFollowUpId
      data['preferredFoodsId'] as String, // _mPreferredFoodsId
      data['weightAreasId'] as String, // _mWeightAreasId
      data['notes'] as String, // _mNotes
      (data['height'] as num).toDouble(), // _mHeight
      (data['weight'] as num).toDouble(), // _mWeight
      SubscriptionType.values.firstWhere(
        (e) => e.name == data['subscriptionType'],
        orElse: () => SubscriptionType.newClient,
      ), // _mSubscriptionType (convert string to enum)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': _mClientId,
      'name': _mName,
      'clientPhoneNum': _mClientPhoneNum,
      'lastVisitId': _mLastVisitId,
      'birthDate': _mBirthdate,
      'clientConstantInfoId': _mClientConstantInfoId,
      'diseaseId': _mDiseaseId,
      'diet': _mDiet,
      'plat': _Plat,
      'clientMonthlyFollowUpId': _mClientMonthlyFollowUpId,
      'notes': _mNotes,
      'height': _mHeight,
      'weight': _mWeight,
      'subscriptionType': _mSubscriptionType.name,
    };
  }
}

Visit visit =
    Visit("abc123", 'id123', DateTime.now(), 'Vegetarian', 75.0, 23.1);

Disease disease = Disease(
    'def456',
    'id123',
    false, // _mHypertension
    true, // _mHypotension
    false, // _mVascular
    false, // _mAnemia
    false, // _mColon
    true, // _mConstipation
    false, // _mFamilyHistoryDM
    true, // _mPreviousOBMed
    false, // _mPreviousOBOperations
    '', // _mRenal
    '', // _mLiver
    '', // _mGit
    '', // _mEndocrine
    '', // _mRheumatic
    '', // _mAllergies
    '', // _mNeuro
    '', // _mPsychiatric
    '', // _mOthers
    '' // _mHormonal
    ); // _mDiseaseId // _mDiseaseId (replace with an actual Disease object)

ClientConstantInfo clientConstantInfo = ClientConstantInfo(
    'const123', // _mClientConstantInfoId
    'id123',
    'mokattam', // _mArea
    Activity.High, // _mActivityLevel
    false, // _mYOYO
    true // _mSports
    );

ClientMonthlyFollowUp clientMonthlyFollowUp = ClientMonthlyFollowUp(
    'mfi123', // _mClientMonthlyFollowUpId
    'id123',
    23.1, // _mBMI
    15.0, // _mPBF
    2.0, // _mWater
    75.0, // _mMaxWeight
    70.0, // _mOptimalWeight
    1500.0, // _mBMR
    2000, // _mMaxCalories
    1800 // _mOptimalCalories
    );

PreferredFoods preferredFoods = PreferredFoods(
    'ghi789', // _mPreferredFoodsId
    'id123',
    true, // _mCarbohydrates
    true, // _mProtein
    false, // _mDairy
    true, // _mVeg
    true, // _mFruits
    'No specific notes' // _mOthers
    );

WeightAreas weightAreas = WeightAreas(
    'jkl012', // _mWeightAreasId
    'id123',
    true, // _mAbdomen
    false, // _mButtocks
    true, // _mWaist
    false, // _mThighs
    true, // _mArms
    false, // _mBreast
    true // _mBack
    );

Client client = Client(
    'id123',
    'John Doe', // _mName
    '1234567890', // _mClientPhoneNum
    'abc123', // _mLastVisitId
    DateTime(1990, 1, 1), // _mBirthdate
    'const123', // _mClientConstantInfoId
    'def456', // _mDiseaseId
    'Vegetarian', // _mDiet
    [70, 71, 72, 73, 74, 75, 76, 77, 78, 79], // _Plat
    'mfi123', // _mClientMonthlyFollowUpId
    'ghi789', // _mPreferredFoodsId
    'jkl012', // _mWeightAreasId
    'No specific notes', // _mNotes
    180.0, // _mHeight
    75.0, // _mWeight
    SubscriptionType.newClient // _mSubscriptionType
    );
