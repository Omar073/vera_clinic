import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Visit {
  late String mVisitId;
  String? mClientId;

  DateTime mDate;
  String mDiet = '';
  double mWeight;
  double mBMI;
  String mVisitNotes = '';
  Visit({
    required String visitId,
    required String? clientId,
    required DateTime date,
    required String diet,
    required double weight,
    required double bmi,
    required String visitNotes,
  })  : mVisitId = visitId,
        mClientId = clientId,
        mDate = date,
        mDiet = diet,
        mWeight = weight,
        mBMI = bmi,
        mVisitNotes = visitNotes;

  // Setters
  set visitId(String visitId) {
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

  set visitNotes(String visitNotes) {
    mVisitNotes = visitNotes;
  }

  void printVisit() {
    debugPrint('\n\t\t<<Visit>>\n'
        'Visit ID: $mVisitId, Client ID: $mClientId, Date: $mDate, '
        'Diet: $mDiet, Weight: $mWeight, BMI: $mBMI, '
        'Visit Notes: $mVisitNotes');
  }

  factory Visit.fromFirestore(Map<String, dynamic> data) {
    return Visit(
      visitId: data['visitId'] as String? ?? '',
      clientId: data['clientId'] as String?,
      date: (data['date'] as Timestamp).toDate(),
      diet: data['diet'] as String? ?? '',
      weight: data['weight'] as double? ?? 0.0,
      bmi: data['bmi'] as double? ?? 0.0,
      visitNotes: data['visitNotes'] as String? ?? '',
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
      'visitNotes': mVisitNotes,
    };
  }
}
