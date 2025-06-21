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
  List<String> mCheckedInClientsIds = [];
  List<String> mDailyClientIds = [];

  Clinic({
    required double? dailyIncome,
    required double? monthlyIncome,
    required int? dailyPatients,
    required int? monthlyPatients,
    required double? dailyExpenses,
    required double? monthlyExpenses,
    required double? dailyProfit,
    required double? monthlyProfit,
    required List<String> checkedInClientsIds,
    required List<String> dailyClientIds,
  })  : mDailyIncome = dailyIncome,
        mMonthlyIncome = monthlyIncome,
        mDailyPatients = dailyPatients,
        mMonthlyPatients = monthlyPatients,
        mDailyExpenses = dailyExpenses,
        mMonthlyExpenses = monthlyExpenses,
        mDailyProfit = dailyProfit,
        mMonthlyProfit = monthlyProfit,
        mCheckedInClientsIds = checkedInClientsIds,
        mDailyClientIds = dailyClientIds;

  void printClinic() {
    debugPrint('\n\t\t<<Clinic>>\n'
        'dailyIncome: $mDailyIncome, monthlyIncome: $mMonthlyIncome, '
        'dailyPatients: $mDailyPatients, monthlyPatients: $mMonthlyPatients, '
        'dailyExpenses: $mDailyExpenses, monthlyExpenses: $mMonthlyExpenses, '
        'dailyProfit: $mDailyProfit, monthlyProfit: $mMonthlyProfit');
  }

  factory Clinic.fromFirestore(Map<String, dynamic> data) {
    return Clinic(
      dailyIncome: (data['dailyIncome'] as num?)?.toDouble() ?? 0.0,
      monthlyIncome: (data['monthlyIncome'] as num?)?.toDouble() ?? 0.0,
      dailyPatients: data['dailyPatients'] as int? ?? 0,
      monthlyPatients: data['monthlyPatients'] as int? ?? 0,
      dailyExpenses: (data['dailyExpenses'] as num?)?.toDouble() ?? 0.0,
      monthlyExpenses: (data['monthlyExpenses'] as num?)?.toDouble() ?? 0.0,
      dailyProfit: (data['dailyProfit'] as num?)?.toDouble() ?? 0.0,
      monthlyProfit: (data['monthlyProfit'] as num?)?.toDouble() ?? 0.0,
      checkedInClientsIds: List<String>.from(data['checkedInClientsIds'] ?? []),
      dailyClientIds: List<String>.from(data['dailyClientIds'] ?? []),
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
      'checkedInClientsIds': mCheckedInClientsIds,
      'dailyClientIds': mDailyClientIds,
    };
  }
}