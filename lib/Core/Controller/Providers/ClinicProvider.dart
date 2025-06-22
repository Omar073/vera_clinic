import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../../Model/Classes/Clinic.dart';
import '../../Model/Classes/Client.dart';
import '../../Model/Firebase/ClinicFirestoreMethods.dart';

class ClinicProvider with ChangeNotifier {
  final ClinicFirestoreMethods _clinicFirestoreMethods =
      ClinicFirestoreMethods();
  late Clinic? clinic;
  List<Client?> _checkedInClients = [];

  ClinicFirestoreMethods get clinicFirestoreMethods => _clinicFirestoreMethods;
  List<Client?> get checkedInClients => _checkedInClients;

  Future<Clinic?> getClinic() async {
    try {
      clinic = await _clinicFirestoreMethods.fetchClinic();
      notifyListeners();
      return clinic;
    } catch (e) {
      debugPrint('Error getting clinic: $e');
      return null;
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    try {
      await _clinicFirestoreMethods.updateClinic(clinic);
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating clinic(provider): $e');
    }
  }

  Future<void> checkInClient(Client client) async {
    try {
      if (clinic == null) return;
      await getClinic();
      checkedInClients.add(client);
      clinic!.mCheckedInClientsIds.add(client.mClientId);
      if (!clinic!.mDailyClientIds.contains(client.mClientId)) {
        clinic!.mDailyClientIds.add(client.mClientId);
      }
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error adding checked-in client: $e');
    }
  }

  Future<void> checkOutClient(Client client) async {
    try {
      if (clinic == null) return;
      checkedInClients.remove(client);
      clinic!.mCheckedInClientsIds.remove(client.mClientId);
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error removing checked-in client: $e');
    }
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
    try {
      await getClinic();
      if (clinic == null) {
        debugPrint('Clinic is null');
        return [];
      }

      // for debugging purposes only (not relevant)
      // for (var c in checkedInClients) {
      //   debugPrint('Checked in client before: ${c?.mName}');
      // }

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
      // for (var c in checkedInClients) {
      //   debugPrint('Checked in client: ${c?.mName}');
      // }
      notifyListeners();
      return checkedInClients;
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
      return [];
    }
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
    try {
      if (clinic == null) return;
      clinic!.mDailyPatients = (clinic!.mDailyPatients ?? 0) + 1;
      clinic!.mMonthlyPatients = (clinic!.mMonthlyPatients ?? 0) + 1;
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error incrementing daily patients: $e');
    }
  }

  Future<void> updateDailyIncome(double income) async {
    try {
      if (clinic == null) return;
      debugPrint('Current daily income: ${clinic!.mDailyIncome}');
      clinic!.mDailyIncome = (clinic!.mDailyIncome ?? 0) + income;
      debugPrint('Updated daily income: ${clinic!.mDailyIncome}');

      clinic!.mMonthlyIncome = (clinic!.mMonthlyIncome ?? 0) + income;
      await _updateDailyProfit();
    } catch (e) {
      debugPrint('Error updating daily income: $e');
    }
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
    try {
      if (clinic == null) return;
      clinic!.mDailyProfit =
          (clinic!.mDailyIncome ?? 0) - (clinic!.mDailyExpenses ?? 0);
      clinic!.mMonthlyProfit =
          (clinic!.mMonthlyIncome ?? 0) - (clinic!.mMonthlyExpenses ?? 0);
      await updateClinic(clinic!);
    } catch (e) {
      debugPrint('Error updating daily profit: $e');
    }
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
