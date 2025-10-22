import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../../Model/Classes/Clinic.dart';
import '../../Model/Classes/Client.dart';
import '../../Model/Firebase/ClinicFirestoreMethods.dart';
import '../../Model/CustomExceptions.dart';

class ClinicProvider with ChangeNotifier {
  final ClinicFirestoreMethods _clinicFirestoreMethods =
      ClinicFirestoreMethods();
  Clinic? clinic;
  List<Client?> _checkedInClients = [];

  // Retry status for UI feedback during fetches
  int? _currentRetryAttempt;
  int? _maxRetryAttempts;
  String? _lastRetryErrorMessage;

  ClinicFirestoreMethods get clinicFirestoreMethods => _clinicFirestoreMethods;
  List<Client?> get checkedInClients => _checkedInClients;
  int? get currentRetryAttempt => _currentRetryAttempt;
  int? get maxRetryAttempts => _maxRetryAttempts;
  String? get lastRetryErrorMessage => _lastRetryErrorMessage;

  Future<Clinic?> getClinic() async {
    try {
      // Reset retry status before a fresh fetch
      _currentRetryAttempt = null;
      _maxRetryAttempts = null;
      _lastRetryErrorMessage = null;
      // Avoid notifying during build: schedule state change after current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      clinic = await _clinicFirestoreMethods.fetchClinic(
        onRetry: (nextAttempt, maxAttempts, error) {
          // Notify listeners so UI can show a retry status
          debugPrint('إعادة المحاولة $nextAttempt من $maxAttempts: $error');
          _currentRetryAttempt = nextAttempt;
          _maxRetryAttempts = maxAttempts;
          _lastRetryErrorMessage = error.toString();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifyListeners();
          });
        },
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return clinic;
    } catch (e) {
      debugPrint('Error getting clinic: $e');
      return null;
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    await _clinicFirestoreMethods.updateClinic(clinic);
    notifyListeners();
  }

  Future<void> checkInClient(Client client) async {
    if (clinic == null) await getClinic();
    if (clinic == null) return;

    await _clinicFirestoreMethods.checkInClient(client.mClientId);

    if (!checkedInClients.any((c) => c?.mClientId == client.mClientId)) {
      checkedInClients.add(client);
    }
    if (clinic != null &&
        !clinic!.mCheckedInClientsIds.contains(client.mClientId)) {
      clinic!.mCheckedInClientsIds.add(client.mClientId);
    }
    if (!clinic!.mDailyClientIds.contains(client.mClientId)) {
      clinic!.mDailyClientIds.add(client.mClientId);
    }

    await updateClinic(clinic!);
    notifyListeners();
  }

  Future<void> checkOutClient(Client client) async {
    if (clinic == null) await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'لا يمكن تسجيل الخروج, بيانات العيادة غير متوفرة');
    }
    clinic!.mCheckedInClientsIds.remove(client.mClientId);
    checkedInClients.removeWhere((c) => c?.mClientId == client.mClientId);
    await updateClinic(clinic!);
    notifyListeners();
  }

  Future<void> removeClientFromDailyList(String clientId) async {
    try {
      if (clinic == null) return;
      clinic!.mDailyClientIds.remove(clientId);
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error removing client from daily list: $e');
    }
  }

  Future<void> clearCheckedInClients() async {
    try {
      if (clinic == null) return;
      _checkedInClients.clear();
      clinic!.mCheckedInClientsIds.clear();
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error clearing checked-in clients: $e');
    }
  }

  Future<List<Client?>> getCheckedInClients(BuildContext context) async {
    // Try to get clinic data. If it fails (returns null), throw an exception.
    if (await getClinic() == null) {
      throw FirebaseOperationException(
          'فشل تحميل بيانات العيادة, الرجاء المحاولة مرة أخرى');
    }

    // If we reach here, clinic is guaranteed to be non-null.
    List<Client?> newCheckedInClients = [];
    for (var clientId in clinic!.mCheckedInClientsIds) {
      Client? client =
          await context.read<ClientProvider>().getClientById(clientId);
      newCheckedInClients.add(client);
    }
    _checkedInClients = newCheckedInClients;

    if (checkedInClients.isEmpty) {
      debugPrint("No checked in clients");
    }
    notifyListeners();
    return checkedInClients;
  }

  Future<bool> isClientCheckedIn(String clientId) async {
    try {
      await getClinic();
      if (clinic == null) {
        debugPrint('Clinic is null');
        return false;
      }
      return clinic!.mCheckedInClientsIds.contains(clientId);
    } catch (e) {
      debugPrint('Error checking if client is checked in: $e');
      return false;
    }
  }

  Future<void> incrementDailyPatients() async {
    if (clinic == null) await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'لا يمكن تحديث البيانات, بيانات العيادة غير متوفرة');
    }
    clinic!.mDailyPatients = (clinic!.mDailyPatients ?? 0) + 1;
    clinic!.mMonthlyPatients = (clinic!.mMonthlyPatients ?? 0) + 1;
    await updateClinic(clinic!);
  }

  Future<void> updateDailyIncome(double income) async {
    if (clinic == null) await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'لا يمكن تحديث البيانات, بيانات العيادة غير متوفرة');
    }
    debugPrint('Current daily income: ${clinic!.mDailyIncome}');
    clinic!.mDailyIncome = (clinic!.mDailyIncome ?? 0) + income;
    debugPrint('Updated daily income: ${clinic!.mDailyIncome}');

    clinic!.mMonthlyIncome = (clinic!.mMonthlyIncome ?? 0) + income;
    await _updateDailyProfit();
  }

  Future<void> updateDailyExpenses(double expenses) async {
    try {
      if (clinic == null) return;
      clinic!.mDailyExpenses = (clinic!.mDailyExpenses ?? 0) + expenses;
      clinic!.mMonthlyExpenses = (clinic!.mMonthlyExpenses ?? 0) + expenses;
      await _updateDailyProfit();
    } catch (e) {
      debugPrint('Error updating daily expenses: $e');
    }
  }

  Future<void> updateMonthlyExpenses(double expenses) async {
    try {
      if (clinic == null) return;
      clinic!.mMonthlyExpenses = (clinic!.mMonthlyExpenses ?? 0) + expenses;
      await _updateMonthlyProfit();
    } catch (e) {
      debugPrint('Error updating monthly expenses: $e');
    }
  }

  Future<void> _updateDailyProfit() async {
    if (clinic == null) await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'لا يمكن تحديث البيانات, بيانات العيادة غير متوفرة');
    }
    clinic!.mDailyProfit =
        (clinic!.mDailyIncome ?? 0) - (clinic!.mDailyExpenses ?? 0);
    clinic!.mMonthlyProfit =
        (clinic!.mMonthlyIncome ?? 0) - (clinic!.mMonthlyExpenses ?? 0);
    await updateClinic(clinic!);
  }

  Future<void> _updateMonthlyProfit() async {
    try {
      if (clinic == null) return;
      clinic!.mMonthlyProfit =
          (clinic!.mMonthlyIncome ?? 0) - (clinic!.mMonthlyExpenses ?? 0);
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error updating monthly profit: $e');
    }
  }

  Future<void> dailyClear() async {
    try {
      if (clinic == null) return;
      clinic!.mDailyIncome = 0;
      clinic!.mDailyExpenses = 0;
      clinic!.mDailyProfit = 0;
      clinic!.mDailyPatients = 0;
      clinic!.mCheckedInClientsIds.clear();
      clinic!.mDailyClientIds.clear();
      _checkedInClients.clear();
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error clearing daily data: $e');
    }
  }

  Future<void> monthlyClear() async {
    try {
      if (clinic == null) return;
      clinic!.mMonthlyIncome = 0;
      clinic!.mMonthlyExpenses = 0;
      clinic!.mMonthlyProfit = 0;
      clinic!.mMonthlyPatients = 0;
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error clearing monthly data: $e');
    }
  }

  Future<void> syncDailyClientsWithCheckedIn() async {
    try {
      await getClinic();
      if (clinic == null) return;

      bool hasChanges = false;
      for (String clientId in clinic!.mCheckedInClientsIds) {
        if (!clinic!.mDailyClientIds.contains(clientId)) {
          clinic!.mDailyClientIds.add(clientId);
          hasChanges = true;
        }
      }

      if (hasChanges) {
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error syncing daily clients with checked-in clients: $e');
    }
  }
}
