enum Activity { Sedentary, Mid, High }

class ClientConstantInfo {
  String _mClientConstantInfoId;
  String _mClientPhoneNum;
  String _mArea;
  Activity _mActivityLevel;
  bool _mYOYO;
  bool _mSports;

  ClientConstantInfo(this._mClientConstantInfoId, this._mClientPhoneNum,
      this._mArea, this._mActivityLevel, this._mYOYO, this._mSports);

  //getters and setters
  String get clientConstantInfoId => _mClientConstantInfoId;
  String get clientPhoneNum => _mClientPhoneNum;
  String get area => _mArea;
  Activity get activityLevel => _mActivityLevel;
  bool get YOYO => _mYOYO;
  bool get sports => _mSports;

  set clientConstantInfoId(String clientConstantInfoId) {
    _mClientConstantInfoId = clientConstantInfoId;
  }

  set clientPhoneNum(String clientPhoneNum) {
    _mClientPhoneNum = clientPhoneNum;
  }

  set area(String area) {
    _mArea = area;
  }

  set activityLevel(Activity activityLevel) {
    _mActivityLevel = activityLevel;
  }

  set YOYO(bool YOYO) {
    _mYOYO = YOYO;
  }

  set sports(bool sports) {
    _mSports = sports;
  }

  factory ClientConstantInfo.fromFirestore(Map<String, dynamic> data) {
    return ClientConstantInfo(
        data['clientConstantInfoId'] as String,
        data['clientPhoneNum'] as String,
        data['area'] as String,
        Activity.values.firstWhere(
          (e) => e.name == (data['activityLevel'] as String).toLowerCase(),
          orElse: () => Activity.Sedentary,
        ),
        data['YOYO'] as bool,
        data['sports'] as bool);
  }

  Map<String, dynamic> toMap() {
    return {
      'clientConstantInfoId': _mClientConstantInfoId,
      'clientPhoneNum': _mClientPhoneNum,
      'area': _mArea,
      'activityLevel': _mActivityLevel.name,
      'YOYO': _mYOYO,
      'sports': _mSports,
    };
  }
}
