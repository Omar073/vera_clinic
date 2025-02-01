import 'package:flutter/cupertino.dart';

class WeightAreas {
  late String mWeightAreasId;
  String? mClientId;

  bool mAbdomen = false;
  bool mButtocks = false;
  bool mWaist = false;
  bool mThighs = false;
  bool mArms = false;
  bool mBreast = false;
  bool mBack = false;

  WeightAreas({
    required String weightAreasId,
    required String? clientId,
    required bool abdomen,
    required bool buttocks,
    required bool waist,
    required bool thighs,
    required bool arms,
    required bool breast,
    required bool back,
  })  : mWeightAreasId = weightAreasId,
        mClientId = clientId,
        mAbdomen = abdomen,
        mButtocks = buttocks,
        mWaist = waist,
        mThighs = thighs,
        mArms = arms,
        mBreast = breast,
        mBack = back;

  // Setters
  set weightAreasId(String weightAreasId) {
    mWeightAreasId = weightAreasId;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set abdomen(bool abdomen) {
    mAbdomen = abdomen;
  }

  set buttocks(bool buttocks) {
    mButtocks = buttocks;
  }

  set waist(bool waist) {
    mWaist = waist;
  }

  set thighs(bool thighs) {
    mThighs = thighs;
  }

  set arms(bool arms) {
    mArms = arms;
  }

  set breast(bool breast) {
    mBreast = breast;
  }

  set back(bool back) {
    mBack = back;
  }

  void printWeightAreas() {
    debugPrint('\n\t\t<<WeightAreas>>\n'
        'WeightAreasId: $mWeightAreasId, ClientId: $mClientId, '
        'Abdomen: $mAbdomen, Buttocks: $mButtocks, Waist: $mWaist, '
        'Thighs: $mThighs, Arms: $mArms, Breast: $mBreast, Back: $mBack');
  }

  factory WeightAreas.fromFirestore(Map<String, dynamic> map) {
    return WeightAreas(
      weightAreasId: map['weightAreasId'] as String? ?? "",
      clientId: map['clientId'] as String? ?? "",
      abdomen: map['abdomen'] as bool,
      buttocks: map['buttocks'] as bool,
      waist: map['waist'] as bool,
      thighs: map['thighs'] as bool,
      arms: map['arms'] as bool,
      breast: map['breast'] as bool,
      back: map['back'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weightAreasId': mWeightAreasId,
      'clientId': mClientId,
      'abdomen': mAbdomen,
      'buttocks': mButtocks,
      'waist': mWaist,
      'thighs': mThighs,
      'arms': mArms,
      'breast': mBreast,
      'back': mBack,
    };
  }
}
