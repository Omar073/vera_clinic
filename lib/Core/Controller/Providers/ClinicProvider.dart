import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../../Model/Classes/Clinic.dart';
import '../../Model/Classes/Client.dart';
import '../../Model/Firebase/ClinicFirestoreMethods.dart';
import '../../Model/CustomExceptions.dart';

import '../../../Core/Services/DebugLoggerService.dart';

class ClinicProvider with ChangeNotifier {
  final ClinicFirestoreMethods _clinicFirestoreMethods =
      ClinicFirestoreMethods();
  Clinic? clinic;
  List<Client> _checkedInClients = [];

  // Retry status for UI feedback during fetches
  int? _currentRetryAttempt;
  int? _maxRetryAttempts;
  String? _lastRetryErrorMessage;

  ClinicFirestoreMethods get clinicFirestoreMethods => _clinicFirestoreMethods;
  List<Client> get checkedInClients => _checkedInClients;

  /// “Upsert” (update-or-insert) for the local client cache: updates the
  /// existing entry when the `clientId` is present, otherwise appends a new one.
  void _upsertOrReplaceCheckedInClient(Client client) {
    final clientId = client.mClientId;
    if (clientId.isEmpty) {
      return;
    }
    final existingIndex =
        checkedInClients.indexWhere((c) => c.mClientId == clientId);
    if (existingIndex != -1) {
      checkedInClients[existingIndex] = client;
    } else {
      checkedInClients.add(client);
    }
  }

  void _removeDuplicateCheckedInClients() {
    final seen = <String>{};
    final List<Client> uniqueList = [];
    for (final client in checkedInClients) {
      final clientId = client.mClientId;
      if (clientId.isEmpty) {
        mDebug(
            'ClinicProvider dedup: encountered client with empty ID, skipping entry');
        continue;
      }
      if (seen.contains(clientId)) {
        continue;
      }
      seen.add(clientId);
      uniqueList.add(client);
    }
    checkedInClients
      ..clear()
      ..addAll(uniqueList);
  }

  Map<String, bool> _extractArrivalStates(Clinic? clinic) {
    if (clinic == null) return {};
    final Map<String, bool> states = {};
    clinic.mCheckedInClients.forEach((clientId, data) {
      states[clientId] = (data['hasArrived'] as bool?) ?? false;
    });
    return states;
  }

  bool _haveArrivalStatesChanged(
      Map<String, bool> previous, Map<String, bool> current) {
    if (identical(previous, current)) return false;
    if (previous.length != current.length) return true;
    for (final entry in current.entries) {
      if (previous[entry.key] != entry.value) {
        return true;
      }
    }
    for (final key in previous.keys) {
      if (!current.containsKey(key)) {
        return true;
      }
    }
    return false;
  }

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
          mDebug('إعادة المحاولة $nextAttempt من $maxAttempts: $error');
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
      mDebug('Error getting clinic: $e');
      return null;
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    await _clinicFirestoreMethods.updateClinic(clinic);
    notifyListeners();
  }

  Future<void> checkInClient(Client client, String checkInTime) async {
    if (clinic == null && await getClinic() == null) return;

    await _clinicFirestoreMethods.checkInClient(client.mClientId, checkInTime);

    // Ensure the local cache mirrors Firestore immediately, even before the next sync.
    _upsertOrReplaceCheckedInClient(client);
    _removeDuplicateCheckedInClients();

    // Update the in-memory clinic snapshot so dependent UI sees the new entry.
    if (clinic != null) {
      clinic!.addCheckedInClient(client.mClientId, checkInTime);
    }
    if (!clinic!.mDailyClientIds.contains(client.mClientId)) {
      clinic!.mDailyClientIds.add(client.mClientId);
    }

    await updateClinic(clinic!);
    notifyListeners();
  }

  Future<void> toggleArrivedStatus(String clientId) async {
    if (clinic == null) return;

    final currentStatus = clinic!.hasClientArrived(clientId);
    await _clinicFirestoreMethods.updateArrivedStatus(clientId, !currentStatus);
    clinic!.toggleHasArrived(clientId);

    // Re-order the local list to move the toggled client to the end
    final clientIndex =
        checkedInClients.indexWhere((c) => c.mClientId == clientId);
    if (clientIndex != -1) {
      final client = checkedInClients.removeAt(clientIndex);
      checkedInClients.add(client);
    }

    notifyListeners();
  }

  Future<void> checkOutClient(Client client) async {
    if (clinic == null) await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'لا يمكن تسجيل الخروج, بيانات العيادة غير متوفرة');
    }

    await _clinicFirestoreMethods.checkOutClient(client.mClientId);
    clinic!.removeCheckedInClient(client.mClientId);
    checkedInClients.removeWhere((c) => c.mClientId == client.mClientId);
    await updateClinic(clinic!);
    notifyListeners();
  }

  Future<void> removeClientFromDailyList(String clientId) async {
    try {
      if (clinic == null) return;
      clinic!.mDailyClientIds.remove(clientId);
      await updateClinic(clinic!);
    } catch (e) {
      mDebug('Error removing client from daily list: $e');
    }
  }

  Future<void> clearCheckedInClients() async {
    try {
      if (clinic == null) return;
      checkedInClients.clear();
      clinic!.mCheckedInClients.clear();
      await updateClinic(clinic!);
    } catch (e) {
      mDebug('Error clearing checked-in clients: $e');
    }
  }

  Future<List<Client>> getCheckedInClients(BuildContext context) async {
    _removeDuplicateCheckedInClients();
    final previousArrivalStates = _extractArrivalStates(clinic);
    // 1. Fetch latest clinic data. This updates `this.clinic`.
    await getClinic();
    if (clinic == null) {
      throw FirebaseOperationException(
          'فشل تحميل بيانات العيادة, الرجاء المحاولة مرة أخرى');
    }
    final currentArrivalStates = _extractArrivalStates(clinic);

    final newClientIds = clinic!.getCheckedInClientIds().toSet();
    final currentClientIds = checkedInClients.map((c) => c.mClientId).toSet();

    bool listChanged = false;

    // 2. Remove clients who are no longer checked in
    checkedInClients.removeWhere((client) {
      if (!newClientIds.contains(client.mClientId)) {
        listChanged = true;
        return true;
      }
      return false;
    });

    // 3. Add any new clients to the end of the list
    for (final clientId in newClientIds) {
      if (!currentClientIds.contains(clientId)) {
        final client =
            await context.read<ClientProvider>().getClientById(clientId);
        if (client != null) {
          _upsertOrReplaceCheckedInClient(client);
          listChanged = true;
        } else {
          mDebug(
              "Warning: Client with ID $clientId not found, but was in checked-in list.");
        }
      }
    }

    final arrivalStatusChanged =
        _haveArrivalStatesChanged(previousArrivalStates, currentArrivalStates);

    if (listChanged || arrivalStatusChanged) {
      _removeDuplicateCheckedInClients();
      notifyListeners();
    }

    return checkedInClients;
  }

  Future<bool> isClientCheckedIn(String clientId) async {
    try {
      await getClinic();
      if (clinic == null) {
        mDebug('Clinic is null');
        return false;
      }
      return clinic!.isClientCheckedIn(clientId);
    } catch (e) {
      mDebug('Error checking if client is checked in: $e');
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
    mDebug('Current daily income: ${clinic!.mDailyIncome}');
    clinic!.mDailyIncome = (clinic!.mDailyIncome ?? 0) + income;
    mDebug('Updated daily income: ${clinic!.mDailyIncome}');

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
      mDebug('Error updating daily expenses: $e');
    }
  }

  Future<void> updateMonthlyExpenses(double expenses) async {
    try {
      if (clinic == null) return;
      clinic!.mMonthlyExpenses = (clinic!.mMonthlyExpenses ?? 0) + expenses;
      await _updateMonthlyProfit();
    } catch (e) {
      mDebug('Error updating monthly expenses: $e');
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
      mDebug('Error updating monthly profit: $e');
    }
  }

  Future<void> dailyClear() async {
    try {
      if (clinic == null) return;
      clinic!.mDailyIncome = 0;
      clinic!.mDailyExpenses = 0;
      clinic!.mDailyProfit = 0;
      clinic!.mDailyPatients = 0;
      clinic!.mCheckedInClients.clear();
      clinic!.mDailyClientIds.clear();
      checkedInClients.clear();
      await updateClinic(clinic!);
    } catch (e) {
      mDebug('Error clearing daily data: $e');
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
      mDebug('Error clearing monthly data: $e');
    }
  }

  Future<void> syncDailyClientsWithCheckedIn() async {
    try {
      await getClinic();
      if (clinic == null) return;

      bool hasChanges = false;
      for (String clientId in clinic!.getCheckedInClientIds()) {
        if (!clinic!.mDailyClientIds.contains(clientId)) {
          clinic!.mDailyClientIds.add(clientId);
          hasChanges = true;
        }
      }

      if (hasChanges) {
        await updateClinic(clinic!);
      }
    } catch (e) {
      mDebug('Error syncing daily clients with checked-in clients: $e');
    }
  }
}
