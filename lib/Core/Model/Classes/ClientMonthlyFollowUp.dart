import 'package:flutter/cupertino.dart';

class ClientMonthlyFollowUp {
  late String mClientMonthlyFollowUpId;
  String? mClientId;

  double? mBMI;
  double? mPBF;
  double? mWater;
  double? mMaxWeight;
  double? mOptimalWeight;
  double? mBMR;
  double? mMaxCalories;
  double? mDailyCalories;

  ClientMonthlyFollowUp({
    required String clientMonthlyFollowUpId,
    required String? clientId,
    required double? bmi,
    required double? pbf,
    required double? water,
    required double? maxWeight,
    required double? optimalWeight,
    required double? bmr,
    required double? maxCalories,
    required double? dailyCalories,
  })  : mClientMonthlyFollowUpId = clientMonthlyFollowUpId,
        mClientId = clientId,
        mBMI = bmi,
        mPBF = pbf,
        mWater = water,
        mMaxWeight = maxWeight,
        mOptimalWeight = optimalWeight,
        mBMR = bmr,
        mMaxCalories = maxCalories,
        mDailyCalories = dailyCalories;

  set clientMonthlyFollowUpId(String clientMonthlyFollowUpId) {
    mClientMonthlyFollowUpId = clientMonthlyFollowUpId;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set bmi(double? bmi) {
    mBMI = bmi;
  }

  set pbf(double? pbf) {
    mPBF = pbf;
  }

  set water(double? water) {
    mWater = water;
  }

  set maxWeight(double? maxWeight) {
    mMaxWeight = maxWeight;
  }

  set optimalWeight(double? optimalWeight) {
    mOptimalWeight = optimalWeight;
  }

  set bmr(double? bmr) {
    mBMR = bmr;
  }

  set maxCalories(double? maxCalories) {
    mMaxCalories = maxCalories;
  }

  set dailyCalories(double? dailyCalories) {
    mDailyCalories = dailyCalories;
  }

  void printClientMonthlyFollowUp() {
    debugPrint('\n\t\t<<ClientMonthlyFollowUp>>\n'
        'ClientMonthlyFollowUpId: $mClientMonthlyFollowUpId, '
        'ClientId: $mClientId, BMI: $mBMI, PBF: $mPBF, Water: $mWater, '
        'MaxWeight: $mMaxWeight, OptimalWeight: $mOptimalWeight, '
        'BMR: $mBMR, MaxCalories: $mMaxCalories, '
        'DailyCalories: $mDailyCalories');
  }

  factory ClientMonthlyFollowUp.fromFirestore(Map<String, dynamic> data) {
    return ClientMonthlyFollowUp(
      clientMonthlyFollowUpId: data['clientMonthlyFollowUpId'] as String? ?? '',
      clientId: data['clientId'] as String? ?? '',
      bmi: data['BMI'] as double? ?? 0.0,
      pbf: data['PBF'] as double? ?? 0.0,
      water: data['water'] as double? ?? 0.0,
      maxWeight: data['maxWeight'] as double? ?? 0.0,
      optimalWeight: data['optimalWeight'] as double? ?? 0.0,
      bmr: data['BMR'] as double? ?? 0.0,
      maxCalories: data['maxCalories'] as double? ?? 0,
      dailyCalories: data['dailyCalories'] as double? ?? 0,
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
    };
  }
}
