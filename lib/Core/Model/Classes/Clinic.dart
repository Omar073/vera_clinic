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
  Map<String, Map<String, dynamic>> mCheckedInClients = {};
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
    required Map<String, Map<String, dynamic>> checkedInClients,
    required List<String> dailyClientIds,
  })  : mDailyIncome = dailyIncome,
        mMonthlyIncome = monthlyIncome,
        mDailyPatients = dailyPatients,
        mMonthlyPatients = monthlyPatients,
        mDailyExpenses = dailyExpenses,
        mMonthlyExpenses = monthlyExpenses,
        mDailyProfit = dailyProfit,
        mMonthlyProfit = monthlyProfit,
        mCheckedInClients = checkedInClients,
        mDailyClientIds = dailyClientIds;

  void printClinic() {
    debugPrint('\n\t\t<<Clinic>>\n'
        'dailyIncome: $mDailyIncome, monthlyIncome: $mMonthlyIncome, '
        'dailyPatients: $mDailyPatients, monthlyPatients: $mMonthlyPatients, '
        'dailyExpenses: $mDailyExpenses, monthlyExpenses: $mMonthlyExpenses, '
        'dailyProfit: $mDailyProfit, monthlyProfit: $mMonthlyProfit, '
        'checkedInClients: $mCheckedInClients');
  }

  bool isClientCheckedIn(String clientId) {
    return mCheckedInClients.containsKey(clientId);
  }

  String? getCheckInTime(String clientId) {
    return mCheckedInClients[clientId]?['checkInTime'] as String?;
  }

  bool hasClientArrived(String clientId) {
    return mCheckedInClients[clientId]?['hasArrived'] as bool? ?? false;
  }

  void addCheckedInClient(String clientId, String checkInTime) {
    mCheckedInClients[clientId] = {
      'checkInTime': checkInTime,
      'hasArrived': false,
    };
  }

  void toggleHasArrived(String clientId) {
    if (mCheckedInClients.containsKey(clientId)) {
      mCheckedInClients[clientId]!['hasArrived'] =
          !hasClientArrived(clientId);
    }
  }

  void removeCheckedInClient(String clientId) {
    mCheckedInClients.remove(clientId);
  }

  List<String> getCheckedInClientIds() {
    return mCheckedInClients.keys.toList();
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
      checkedInClients:
          _migrateCheckedInClients(data['checkedInClients']),
      dailyClientIds: List<String>.from(data['dailyClientIds'] ?? []),
    );
  }

  static Map<String, Map<String, dynamic>> _migrateCheckedInClients(dynamic data) {
    if (data == null || data is! Map) {
      return {};
    }

    final Map<String, dynamic> rawMap = Map<String, dynamic>.from(data);
    final Map<String, Map<String, dynamic>> migratedMap = {};

    rawMap.forEach((clientId, value) {
      if (value is String) {
        // Old format: value is a timestamp string. Migrate it.
        migratedMap[clientId] = {
          'checkInTime': value,
          'hasArrived': false, // Default value
        };
      } else if (value is Map) {
        // New format: value is already a map. Use it as is.
        migratedMap[clientId] = Map<String, dynamic>.from(value);
      }
    });

    return migratedMap;
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
      'checkedInClients': mCheckedInClients,
      'dailyClientIds': mDailyClientIds,
    };
  }
}