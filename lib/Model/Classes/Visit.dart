import 'package:cloud_firestore/cloud_firestore.dart';

class Visit {
  String _mVisitId;
  String _mClientId;

  DateTime _mDate;
  String _mDiet;
  double _mWeight;
  double _mBMI;

  Visit(this._mVisitId, this._mClientId, this._mDate, this._mDiet,
      this._mWeight, this._mBMI);

  // Getters
  String get visitId => _mVisitId;
  DateTime get date => _mDate;
  String get clientId => _mClientId;
  String get diet => _mDiet;
  double get weight => _mWeight;
  double get bmi => _mBMI;

  // Setters
  set visitId(String visitId) {
    _mVisitId = visitId;
  }

  set date(DateTime date) {
    _mDate = date;
  }

  set clientId(String clientId) {
    _mClientId = clientId;
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

  factory Visit.fromFirestore(Map<String, dynamic> data) {
    return Visit(
        data['visitId'] as String,
        data['clientId'] as String,
        (data['date'] as Timestamp).toDate(),
        data['diet'] as String,
        data['weight'] as double,
        data['bmi'] as double);
  }

  Map<String, dynamic> toMap() {
    return {
      'visitId': _mVisitId,
      'clientId': _mClientId,
      'date': _mDate,
      'diet': _mDiet,
      'weight': _mWeight,
      'bmi': _mBMI,
    };
  }
}
