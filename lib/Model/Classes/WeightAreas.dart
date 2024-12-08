class WeightAreas {
  String _mWeightAreasId;
  String _mClientPhoneNum;

  bool _mAbdomen;
  bool _mButtocks;
  bool _mWaist;
  bool _mThighs;
  bool _mArms;
  bool _mBreast;
  bool _mBack;

  WeightAreas(
      this._mWeightAreasId,
      this._mClientPhoneNum,
      this._mAbdomen,
      this._mButtocks,
      this._mWaist,
      this._mThighs,
      this._mArms,
      this._mBreast,
      this._mBack);

  // Getters
  String get weightAreasId => _mWeightAreasId;
  String get clientPhoneNum => _mClientPhoneNum;
  bool get abdomen => _mAbdomen;
  bool get buttocks => _mButtocks;
  bool get waist => _mWaist;
  bool get thighs => _mThighs;
  bool get arms => _mArms;
  bool get breast => _mBreast;
  bool get back => _mBack;

  // Setters
  set weightAreasId(String weightAreasId) {
    _mWeightAreasId = weightAreasId;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
  }

  set abdomen(bool abdomen) {
    _mAbdomen = abdomen;
  }

  set buttocks(bool buttocks) {
    _mButtocks = buttocks;
  }

  set waist(bool waist) {
    _mWaist = waist;
  }

  set thighs(bool thighs) {
    _mThighs = thighs;
  }

  set arms(bool arms) {
    _mArms = arms;
  }

  set breast(bool breast) {
    _mBreast = breast;
  }

  set back(bool back) {
    _mBack = back;
  }

  factory WeightAreas.fromFirestore(Map<String, dynamic> map) {
    return WeightAreas(
      map['weightAreasId'] as String,
      map['clientPhoneNum'] as String,
      map['abdomen'] as bool,
      map['buttocks'] as bool,
      map['waist'] as bool,
      map['thighs'] as bool,
      map['arms'] as bool,
      map['breast'] as bool,
      map['back'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weightAreasId': _mWeightAreasId,
      'clientPhoneNum': _mClientPhoneNum,
      'abdomen': _mAbdomen,
      'buttocks': _mButtocks,
      'waist': _mWaist,
      'thighs': _mThighs,
      'arms': _mArms,
      'breast': _mBreast,
      'back': _mBack,
    };
  }
}
