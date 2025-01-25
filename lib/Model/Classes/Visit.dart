import 'package:cloud_firestore/cloud_firestore.dart';

class Visit {
  String? mVisitId;
  String? mClientId;

  DateTime mDate;
  String mDiet = '';
  double mWeight;
  double mBMI;
Visit({
  required String? visitId,
  required String? clientId,
  required DateTime date,
  required String diet,
  required double weight,
  required double bmi,
})  : mVisitId = visitId,
      mClientId = clientId,
      mDate = date,
      mDiet = diet,
      mWeight = weight,
      mBMI = bmi;


  // Setters
  set visitId(String? visitId) {
    mVisitId = visitId;
  }

  set date(DateTime date) {
    mDate = date;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set diet(String diet) {
    mDiet = diet;
  }

  set weight(double weight) {
    mWeight = weight;
  }

  set bmi(double bmi) {
    mBMI = bmi;
  }

factory Visit.fromFirestore(Map<String, dynamic> data) {
  return Visit(
    visitId: data['visitId'] as String?,
    clientId: data['clientId'] as String?,
    date: (data['date'] as Timestamp).toDate(),
    diet: data['diet'] as String,
    weight: data['weight'] as double,
    bmi: data['bmi'] as double,
  );
}

  Map<String, dynamic> toMap() {
    return {
      'visitId': mVisitId,
      'clientId': mClientId,
      'date': mDate,
      'diet': mDiet,
      'weight': mWeight,
      'bmi': mBMI,
    };
  }
}
