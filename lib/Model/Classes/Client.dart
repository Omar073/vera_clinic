import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vera_clinic/Model/Classes/PreferredFoods.dart';

import 'Disease.dart';
import 'Visit.dart';
import 'WeightAreas.dart';

enum Activity { Sedentary, Mid, High }

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
  // 25 attributes
  String _mName;
  String _mTelephone;
  String _mArea;
  String _mLastVisitId;
  DateTime _mBirthdate;
  String _mDiseaseId;
  String _mDiet;
  bool _mYOYO;
  List<double> _Plat = List.filled(10, 0); // Last 10 stable weights
  Activity _mActivityLevel;
  bool _mSports;
  String _mPreferredFoodsId;
  String _mWeightAreasId;
  String _mNotes;
  double _mHeight;
  double _mWeight;
  double _mBMI;
  double _mPBF;
  double _mWater;
  double _mMaxWeight;
  double _mOptimalWeight;
  double _mBMR;
  int _mMaxCalories;
  int _mOptimalCalories;
  SubscriptionType _mSubscriptionType;
  //TODO: should we try and nest some of these attributes into a new class?

  Client(
      this._mName,
      this._mTelephone,
      this._mArea,
      this._mLastVisitId,
      this._mBirthdate,
      this._mDiseaseId,
      this._mDiet,
      this._mYOYO,
      this._Plat,
      this._mActivityLevel,
      this._mSports,
      this._mPreferredFoodsId,
      this._mWeightAreasId,
      this._mNotes,
      this._mHeight,
      this._mWeight,
      this._mBMI,
      this._mPBF,
      this._mWater,
      this._mMaxWeight,
      this._mOptimalWeight,
      this._mBMR,
      this._mMaxCalories,
      this._mOptimalCalories,
      this._mSubscriptionType);

  // Getters
  String get name => _mName;
  String get telephone => _mTelephone;
  String get area => _mArea;
  String get lastVisitId => _mLastVisitId;
  DateTime get birthdate => _mBirthdate;
  String get diseaseId => _mDiseaseId;
  String get diet => _mDiet;
  bool get YOYO => _mYOYO;
  List<double> get plat => _Plat;
  Activity get activityLevel => _mActivityLevel;
  bool get sports => _mSports;
  String get preferredFoodsId => _mPreferredFoodsId;
  String get weightAreasId => _mWeightAreasId;
  String get notes => _mNotes;
  double get height => _mHeight;
  double get weight => _mWeight;
  double get bmi => _mBMI;
  double get pbf => _mPBF;
  double get water => _mWater;
  double get maxWeight => _mMaxWeight;
  double get optimalWeight => _mOptimalWeight;
  double get bmr => _mBMR;
  int get maxCalories => _mMaxCalories;
  int get optimalCalories => _mOptimalCalories;
  SubscriptionType get subscriptionType => _mSubscriptionType;

// Setters
  set name(String name) {
    _mName = name;
  }

  set telephone(String telephone) {
    _mTelephone = telephone;
  }

  set area(String area) {
    _mArea = area;
  }

  set lastVisitId(String lastVisitId) {
    _mLastVisitId = lastVisitId;
  }

  set birthdate(DateTime birthdate) {
    _mBirthdate = birthdate;
  }

  set diseaseId(String diseaseId) {
    _mDiseaseId = diseaseId;
  }

  set diet(String diet) {
    _mDiet = diet;
  }

  set YOYO(bool YOYO) {
    _mYOYO = YOYO;
  }

  set plat(List<double> plat) {
    _Plat = plat;
  }

  set activityLevel(Activity activityLevel) {
    _mActivityLevel = activityLevel;
  }

  set sports(bool sports) {
    _mSports = sports;
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

  set bmi(double bmi) {
    _mBMI = bmi;
  }

  set pbf(double pbf) {
    _mPBF = pbf;
  }

  set water(double water) {
    _mWater = water;
  }

  set maxWeight(double maxWeight) {
    _mMaxWeight = maxWeight;
  }

  set optimalWeight(double optimalWeight) {
    _mOptimalWeight = optimalWeight;
  }

  set bmr(double bmr) {
    _mBMR = bmr;
  }

  set maxCalories(int maxCalories) {
    _mMaxCalories = maxCalories;
  }

  set optimalCalories(int optimalCalories) {
    _mOptimalCalories = optimalCalories;
  }

  set subscriptionType(SubscriptionType subscriptionType) {
    _mSubscriptionType = subscriptionType;
  }

  factory Client.fromFirestore(Map<String, dynamic> data) {
    // final data = doc.data() as Map<String, dynamic>;
    return Client(
      data['name'] as String, // _mName
      data['telephone'] as String, // _mTelephone
      data['area'] as String, // _mArea
      data['lastVisitId'] as String, // _mLastVisitId
      (data['birthDate'] as Timestamp).toDate(), // _mBirthdate
      data['diseaseId'] as String, // _mDiseaseId
      data['diet'] as String, // _mDiet
      data['YOYO'] as bool, // _mYOYO
      (data['plat'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(), // _Plat
      Activity.values.firstWhere(
        (e) => e.name == (data['activityLevel'] as String).toLowerCase(),
        orElse: () => Activity.Sedentary,
      ), // _mActivityLevel (convert string to enum)
      data['sport'] as bool, // _mSports
      data['preferredFoodsId'] as String, // _mPreferredFoodsId
      data['weightAreasId'] as String, // _mWeightAreasId
      data['notes'] as String, // _mNotes
      (data['height'] as num).toDouble(), // _mHeight
      (data['weight'] as num).toDouble(), // _mWeight
      (data['BMI'] as num).toDouble(), // _mBMI
      (data['PBF'] as num).toDouble(), // _mPBF
      (data['water'] as num).toDouble(), // _mWater
      (data['maxWeight'] as num).toDouble(), // _mMaxWeight
      (data['optimalWeight'] as num).toDouble(), // _mOptimalWeight
      // double.tryParse(data['BMR'] as String) ??
      //     0.0, // _mBMR (convert string to double)
      (data['BMR'] as num).toDouble(), // _mBMR
      (data['maxCalories'] as num).toInt(), // _mMaxCalories
      (data['optimalCalories'] as num).toInt(), // _mOptimalCalories
      SubscriptionType.values.firstWhere(
        (e) => e.name == data['subscriptionType'],
        orElse: () => SubscriptionType.newClient,
      ), // _mSubscriptionType (convert string to enum)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _mName,
      'telephone': _mTelephone,
      'area': _mArea,
      'lastVisitId': _mLastVisitId,
      'birthDate': _mBirthdate,
      'diseaseId': _mDiseaseId,
      'diet': _mDiet,
      'YOYO': _mYOYO,
      'plat': _Plat,
      'activityLevel': _mActivityLevel.name,
      'sport': _mSports,
      'notes': _mNotes,
      'height': _mHeight,
      'weight': _mWeight,
      'BMI': _mBMI,
      'PBF': _mPBF,
      'water': _mWater,
      'maxWeight': _mMaxWeight,
      'optimalWeight': _mOptimalWeight,
      'BMR': _mBMR,
      'maxCalories': _mMaxCalories,
      'optimalCalories': _mOptimalCalories,
      'subscriptionType': _mSubscriptionType.name,
    };
  }
}

Visit visit =
    Visit("abc123", '1234567890', DateTime.now(), 'Vegetarian', 75.0, 23.1);

Disease disease = Disease(
    'def456',
    '1234567890',
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

PreferredFoods preferredFoods = PreferredFoods(
    'ghi789', // _mPreferredFoodsId
    '1234567890',
    true, // _mCarbohydrates
    true, // _mProtein
    false, // _mDairy
    true, // _mVeg
    true, // _mFruits
    'No specific notes' // _mOthers
    );

WeightAreas weightAreas = WeightAreas(
    'jkl012', // _mWeightAreasId
    '1234567890', // _mClientPhoneNum
    true, // _mAbdomen
    false, // _mButtocks
    true, // _mWaist
    false, // _mThighs
    true, // _mArms
    false, // _mBreast
    true // _mBack
    );

Client client = Client(
    'John Doe', // _mName
    '1234567890', // _mTelephone
    'Downtown', // _mArea
    'abc123', // t8y_mLastVisitId
    DateTime(1990, 1, 1), // _mBirthdate
    'def456',
    'Vegetarian', // _mDiet
    true, // _mYOYO
    [70, 71, 72, 73, 74, 75, 76, 77, 78, 79], // _Plat
    Activity.Mid, // _mActivityLevel
    true, // _mSports
    'ghi789', // _mPreferredFoodsId
    'jkl012', // _mWeightAreasId
    'No specific notes', // _mNotes
    180.0, // _mHeight
    75.0, // _mWeight
    23.1, // _mBMI
    15.0, // _mPBF
    60.0, // _mWater
    80.0, // _mMaxWeight
    70.0, // _mOptimalWeight
    1500.0, // _mBMR
    2000, // _mMaxCalories
    1800, // _mOptimalCalories
    SubscriptionType.newClient // _mSubscriptionType
    );
