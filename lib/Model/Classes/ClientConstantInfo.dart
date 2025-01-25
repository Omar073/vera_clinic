enum Activity {sedentary,mid,high,none}

class ClientConstantInfo {
  String? mClientConstantInfoId;
  String? mClientId;

  String mArea = '';
  Activity? mActivityLevel;
  bool mYOYO = false;
  bool mSports = false;

  ClientConstantInfo({
    required String? clientConstantInfoId,
    required String? clientId,
    required String area,
    required Activity? activityLevel,
    required bool YOYO,
    required bool sports,
  })  : mClientConstantInfoId = clientConstantInfoId,
        mClientId = clientId,
        mArea = area,
        mActivityLevel = activityLevel,
        mYOYO = YOYO,
        mSports = sports;

  
  set clientConstantInfoId(String? clientConstantInfoId) {
    mClientConstantInfoId = clientConstantInfoId;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set area(String area) {
    mArea = area;
  }

  set activityLevel(Activity? activityLevel) {
    mActivityLevel = activityLevel;
  }

  set YOYO(bool YOYO) {
    mYOYO = YOYO;
  }

  set sports(bool sports) {
    mSports = sports;
  }

  factory ClientConstantInfo.fromFirestore(Map<String, dynamic> data) {
    return ClientConstantInfo(
      clientConstantInfoId: data['clientConstantInfoId'] as String? ?? '',
      clientId: data['clientId'] as String? ?? '',
      area: data['area'] as String? ?? '',
      activityLevel: Activity.values.firstWhere(
        (e) => e.name == (data['activityLevel'] as String?)?.toLowerCase(),
        orElse: () => Activity.none,
      ) as Activity?,
      YOYO: data['YOYO'] as bool,
      sports: data['sports'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientConstantInfoId': mClientConstantInfoId,
      'clientId': mClientId,
      'area': mArea,
      'activityLevel': mActivityLevel?.name,
      'YOYO': mYOYO,
      'sports': mSports,
    };
  }
}
