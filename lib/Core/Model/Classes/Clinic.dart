import 'package:flutter/cupertino.dart';

class Clinic {
  double? mDailyIncome;
  double? mMonthlyIncome;
  int? mDailyPatients;
  int? mMonthlyPatients;
  double? mDailyExpenses;
  double? mMonthlyExpenses;
  double? mDailyProfit;
  double? mMonthlyProfit;

  Clinic({
    required double? dailyIncome,
    required double? monthlyIncome,
    required int? dailyPatients,
    required int? monthlyPatients,
    required double? dailyExpenses,
    required double? monthlyExpenses,
    required double? dailyProfit,
    required double? monthlyProfit,
  })  : mDailyIncome = dailyIncome,
        mMonthlyIncome = monthlyIncome,
        mDailyPatients = dailyPatients,
        mMonthlyPatients = monthlyPatients,
        mDailyExpenses = dailyExpenses,
        mMonthlyExpenses = monthlyExpenses,
        mDailyProfit = dailyProfit,
        mMonthlyProfit = monthlyProfit;

  double? get dailyIncome => mDailyIncome;
  double? get monthlyIncome => mMonthlyIncome;
  int? get dailyPatients => mDailyPatients;
  int? get monthlyPatients => mMonthlyPatients;
  double? get dailyExpenses => mDailyExpenses;
  double? get monthlyExpenses => mMonthlyExpenses;
  double? get dailyProfit => mDailyProfit;
  double? get monthlyProfit => mMonthlyProfit;

  set dailyIncome(double? value) => mDailyIncome = value;
  set monthlyIncome(double? value) => mMonthlyIncome = value;
  set dailyPatients(int? value) => mDailyPatients = value;
  set monthlyPatients(int? value) => mMonthlyPatients = value;
  set dailyExpenses(double? value) => mDailyExpenses = value;
  set monthlyExpenses(double? value) => mMonthlyExpenses = value;
  set dailyProfit(double? value) => mDailyProfit = value;
  set monthlyProfit(double? value) => mMonthlyProfit = value;

  void printClinic() {
    debugPrint('\n\t\t<<Clinic>>\n'
        'dailyIncome: $mDailyIncome, monthlyIncome: $mMonthlyIncome, '
        'dailyPatients: $mDailyPatients, monthlyPatients: $mMonthlyPatients, '
        'dailyExpenses: $mDailyExpenses, monthlyExpenses: $mMonthlyExpenses, '
        'dailyProfit: $mDailyProfit, monthlyProfit: $mMonthlyProfit');
  }

  factory Clinic.fromFirestore(Map<String, dynamic> data) {
    return Clinic(
      dailyIncome: data['dailyIncome'] as double?,
      monthlyIncome: data['monthlyIncome'] as double?,
      dailyPatients: data['dailyPatients'] as int?,
      monthlyPatients: data['monthlyPatients'] as int?,
      dailyExpenses: data['dailyExpenses'] as double?,
      monthlyExpenses: data['monthlyExpenses'] as double?,
      dailyProfit: data['dailyProfit'] as double?,
      monthlyProfit: data['monthlyProfit'] as double?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dailyIncome': mDailyIncome,
      'monthlyIncome': mMonthlyIncome,
      'dailyPatients': mDailyPatients,
      'monthlyPatients': mMonthlyPatients,
      'dailyExpenses': mDailyExpenses,
      'monthlyExpenses': mMonthlyExpenses,
      'dailyProfit': mDailyProfit,
      'monthlyProfit': mMonthlyProfit,
    };
  }
}

Clinic clinic = Clinic(
  dailyIncome: 1000.0,
  monthlyIncome: 30000.0,
  dailyPatients: 10,
  monthlyPatients: 300,
  dailyExpenses: 500.0,
  monthlyExpenses: 15000.0,
  dailyProfit: 500.0,
  monthlyProfit: 15000.0,
);
