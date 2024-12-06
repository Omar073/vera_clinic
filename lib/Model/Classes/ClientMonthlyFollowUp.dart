class ClientMonthlyFollowUp {
  String _mClientMonthlyFollowUpId;
  String _mClientPhoneNum;
  double _mBMI;
  double _mPBF;
  double _mWater;
  double _mMaxWeight;
  double _mOptimalWeight;
  double _mBMR;
  int _mMaxCalories;
  int _mOptimalCalories;

  ClientMonthlyFollowUp(
      this._mClientMonthlyFollowUpId,
      this._mClientPhoneNum,
      this._mBMI,
      this._mPBF,
      this._mWater,
      this._mMaxWeight,
      this._mOptimalWeight,
      this._mBMR,
      this._mMaxCalories,
      this._mOptimalCalories);

  //getters and setters
  String get clientMonthlyFollowUpId => _mClientMonthlyFollowUpId;
  String get clientPhoneNum => _mClientPhoneNum;
  double get bmi => _mBMI;
  double get pbf => _mPBF;
  double get water => _mWater;
  double get maxWeight => _mMaxWeight;
  double get optimalWeight => _mOptimalWeight;
  double get bmr => _mBMR;
  int get maxCalories => _mMaxCalories;
  int get optimalCalories => _mOptimalCalories;

  set clientMonthlyFollowUpId(String clientMonthlyFollowUpId) {
    _mClientMonthlyFollowUpId = clientMonthlyFollowUpId;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
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

  factory ClientMonthlyFollowUp.fromFirestore(Map<String, dynamic> data) {
    return ClientMonthlyFollowUp(
      data['clientMonthlyFollowUpId'] as String,
      data['clientPhoneNum'] as String,
      data['bmi'] as double,
      data['pbf'] as double,
      data['water'] as double,
      data['maxWeight'] as double,
      data['optimalWeight'] as double,
      data['bmr'] as double,
      data['maxCalories'] as int,
      data['optimalCalories'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientMonthlyFollowUpId': _mClientMonthlyFollowUpId,
      'clientPhoneNum': _mClientPhoneNum,
      'bmi': _mBMI,
      'pbf': _mPBF,
      'water': _mWater,
      'maxWeight': _mMaxWeight,
      'optimalWeight': _mOptimalWeight,
      'bmr': _mBMR,
      'maxCalories': _mMaxCalories,
      'optimalCalories': _mOptimalCalories,
    };
  }
}
