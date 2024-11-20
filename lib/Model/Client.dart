import 'Disease.dart';
import 'Visit.dart';

enum Activity { Sedentary, Mid, High }

class Client {
  String _mName;
  String _mTelephone;
  String _mArea;
  Visit _mLastVisit;
  DateTime _mBirthdate;
  Disease _mDisease;
  String _mDiet;
  bool _mYOYO;
  List<int> _Plat = List.filled(10, 0); // Last 10 stable weights
  Activity _mActivityLevel;
  bool _mSports;
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

  Client(
      this._mName,
      this._mTelephone,
      this._mArea,
      this._mLastVisit,
      this._mBirthdate,
      this._mDisease,
      this._mDiet,
      this._mYOYO,
      this._Plat,
      this._mActivityLevel,
      this._mSports,
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
      this._mOptimalCalories);

  // Getters
  String get name => _mName;
  String get telephone => _mTelephone;
  String get area => _mArea;
  Visit get lastVisit => _mLastVisit;
  DateTime get birthdate => _mBirthdate;
  Disease get disease => _mDisease;
  String get diet => _mDiet;
  bool get YOYO => _mYOYO;
  List<int> get plat => _Plat;
  Activity get activityLevel => _mActivityLevel;
  bool get sports => _mSports;
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

  set lastVisit(Visit lastVisit) {
    _mLastVisit = lastVisit;
  }

  set birthdate(DateTime birthdate) {
    _mBirthdate = birthdate;
  }

  set disease(Disease disease) {
    _mDisease = disease;
  }

  set diet(String diet) {
    _mDiet = diet;
  }

  set YOYO(bool YOYO) {
    _mYOYO = YOYO;
  }

  set plat(List<int> plat) {
    _Plat = plat;
  }

  set activityLevel(Activity activityLevel) {
    _mActivityLevel = activityLevel;
  }

  set sports(bool sports) {
    _mSports = sports;
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
}
