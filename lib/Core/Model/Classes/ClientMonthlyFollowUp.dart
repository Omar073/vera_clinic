import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class ClientMonthlyFollowUp {
  late String mClientMonthlyFollowUpId;
  String? mClientId;

  double? mBMI;
  double? mPBF;
  String? mWater;
  double? mMaxWeight;
  double? mOptimalWeight;
  double? mBMR;
  double? mMaxCalories;
  double? mDailyCalories;
  double? mMuscleMass;
  DateTime? mDate;
  String? mNotes;

  ClientMonthlyFollowUp({
    required String clientMonthlyFollowUpId,
    required String? clientId,
    required double? bmi,
    required double? pbf,
    required String? water,
    required double? maxWeight,
    required double? optimalWeight,
    required double? bmr,
    required double? maxCalories,
    required double? dailyCalories,
    required double? muscleMass,
    required DateTime? date,
    required String? notes,
  })  : mClientMonthlyFollowUpId = clientMonthlyFollowUpId,
        mClientId = clientId,
        mBMI = bmi,
        mPBF = pbf,
        mWater = water,
        mMaxWeight = maxWeight,
        mOptimalWeight = optimalWeight,
        mBMR = bmr,
        mMaxCalories = maxCalories,
        mDailyCalories = dailyCalories,
        mMuscleMass = muscleMass,
        mDate = date,
        mNotes = notes;

  void printClientMonthlyFollowUp() {
    mDebug('\n\t\t<<ClientMonthlyFollowUp>>\n'
        'ClientMonthlyFollowUpId: $mClientMonthlyFollowUpId, '
        'ClientId: $mClientId, BMI: $mBMI, PBF: $mPBF, Water: $mWater, '
        'MaxWeight: $mMaxWeight, OptimalWeight: $mOptimalWeight, '
        'BMR: $mBMR, MaxCalories: $mMaxCalories, '
        'DailyCalories: $mDailyCalories, MuscleMass: $mMuscleMass, '
        'Date: $mDate, Notes: $mNotes');
  }

  factory ClientMonthlyFollowUp.fromFirestore(Map<String, dynamic> data) {
    return ClientMonthlyFollowUp(
      clientMonthlyFollowUpId: data['clientMonthlyFollowUpId'] as String? ?? '',
      clientId: data['clientId'] as String? ?? '',
      bmi: data['BMI'] as double? ?? 0.0,
      pbf: data['PBF'] as double? ?? 0.0,
      water: (data['water'] ?? '').toString(),
      maxWeight: data['maxWeight'] as double? ?? 0.0,
      optimalWeight: data['optimalWeight'] as double? ?? 0.0,
      bmr: data['BMR'] as double? ?? 0.0,
      maxCalories: data['maxCalories'] as double? ?? 0,
      dailyCalories: data['dailyCalories'] as double? ?? 0,
      muscleMass: data['muscleMass'] as double? ?? 0.0,
      date: (data['date'] as Timestamp?)?.toDate(),
      notes: data['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientMonthlyFollowUpId': mClientMonthlyFollowUpId,
      'clientId': mClientId,
      'BMI': mBMI,
      'PBF': mPBF,
      'water': mWater,
      'maxWeight': mMaxWeight,
      'optimalWeight': mOptimalWeight,
      'BMR': mBMR,
      'maxCalories': mMaxCalories,
      'dailyCalories': mDailyCalories,
      'muscleMass': mMuscleMass,
      'date': mDate,
      'notes': mNotes,
    };
  }
}
