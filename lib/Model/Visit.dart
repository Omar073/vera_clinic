class Visit {
  DateTime _mDate;
  String _mClientPhoneNum;
  String _mDiet;
  double _mWeight;
  double _mBMI;

  Visit(this._mDate, this._mClientPhoneNum, this._mDiet, this._mWeight,
      this._mBMI);

  // Getters
  DateTime get date => _mDate;
  String get clientPhoneNum => _mClientPhoneNum;
  String get diet => _mDiet;
  double get weight => _mWeight;
  double get bmi => _mBMI;

  // Setters
  set date(DateTime date) {
    _mDate = date;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
  }

  set diet(String diet) {
    _mDiet = diet;
  }

  set weight(double weight) {
    _mWeight = weight;
  }

  set bmi(double bmi) {
    _mBMI = bmi;
  }
}
