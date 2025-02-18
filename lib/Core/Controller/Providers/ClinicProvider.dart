import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/CheckInPage/View/InfoCards/CheckInButton.dart';
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

  Future<void> getClinic() async {
    try {
      clinic = await _clinicFirestoreMethods.fetchClinic();
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting clinic: $e');
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
      if (clinic != null) {
        checkedInClients.add(client);
        clinic!.mCheckedInClientsIds.add(client.mClientId);
        await updateClinic(clinic!);
        //debug print
        for (var c in checkedInClients) {
          debugPrint('Checked in client: ${c?.mName}');
        }
      }
    } catch (e) {
      debugPrint('Error adding checked-in client: $e');
    }
  }

  Future<void> checkOutClient(Client client) async {
    try {
      if (clinic != null) {
        checkedInClients.remove(client);
        clinic!.mCheckedInClientsIds.remove(client.mClientId);
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error removing checked-in client: $e');
    }
    notifyListeners();
  }

  Future<void> clearCheckedInClients() async {
    try {
      if (clinic != null) {
        _checkedInClients.clear();
        clinic!.mCheckedInClientsIds.clear();
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error clearing checked-in clients: $e');
    }
  }

  Future<List<Client?>> getCheckedInClients(BuildContext context) async {
    try {
      debugPrint("Getting checked in clients");
      await getClinic();
      if (clinic == null) {
        debugPrint('Clinic is null');
        return [];
      }
      for (var c in checkedInClients) {
        debugPrint('Checked in client before: ${c?.mName}');
      }
      for (var clientId in clinic!.mCheckedInClientsIds) {
        // check if the client is already checked in
        if (!checkedInClients.any((client) => client?.mClientId == clientId)) {
          Client? client =
              await context.read<ClientProvider>().getClientById(clientId);
          checkedInClients.add(client);
        }
      }
      if (checkedInClients.isEmpty) {
        debugPrint("No checked in clients");
      }
      for (var c in checkedInClients) {
        debugPrint('Checked in client: ${c?.mName}');
      }
      return checkedInClients;
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
      return [];
    }
  }

  Future<bool> isClientCheckedIn(String clientId) async {
    try {
      await getClinic();
      return clinic!.mCheckedInClientsIds.contains(clientId);
    } catch (e) {
      debugPrint('Error checking if client is checked in: $e');
      return false;
    }
  }

  Future<void> updateDailyIncome(double income) async {
    try {
      if (clinic != null) {
        debugPrint('Current daily income: ${clinic!.mDailyIncome}');
        clinic!.mDailyIncome = (clinic!.mDailyIncome ?? 0) + income;
        debugPrint('Updated daily income: ${clinic!.mDailyIncome}');
        clinic!.mMonthlyIncome = (clinic!.mMonthlyIncome ?? 0) + income;
        await updateDailyProfit();
      }
    } catch (e) {
      debugPrint('Error updating daily income: $e');
    }
  }

  Future<void> clearDailyIncome() async {
    try {
      if (clinic != null) {
        clinic!.mDailyIncome = 0;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error clearing daily income: $e');
    }
  }

  Future<void> updateMonthlyIncome(double income) async {
    try {
      if (clinic != null) {
        clinic!.mMonthlyIncome = (clinic!.mMonthlyIncome ?? 0) + income;
        await updateMonthlyProfit();
      }
    } catch (e) {
      debugPrint('Error updating monthly income: $e');
    }
  }

  Future<void> incrementDailyPatients() async {
    try {
      if (clinic != null) {
        clinic!.mDailyPatients = (clinic!.mDailyPatients ?? 0) + 1;
        clinic!.mMonthlyPatients = (clinic!.mMonthlyPatients ?? 0) + 1;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error incrementing daily patients: $e');
    }
  }

  Future<void> clearDailyPatients() async {
    try {
      if (clinic != null) {
        clinic!.mDailyPatients = 0;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error clearing daily patients: $e');
    }
  }

  Future<void> updateDailyExpenses(double expenses) async {
    try {
      if (clinic != null) {
        clinic!.mDailyExpenses = (clinic!.mDailyExpenses ?? 0) + expenses;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error updating daily expenses: $e');
    }
  }

  Future<void> clearDailyExpenses() async {
    try {
      if (clinic != null) {
        clinic!.mDailyExpenses = 0;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error clearing daily expenses: $e');
    }
  }

  Future<void> updateMonthlyExpenses(double expenses) async {
    try {
      if (clinic != null) {
        clinic!.mMonthlyExpenses = (clinic!.mMonthlyExpenses ?? 0) + expenses;
        await updateMonthlyProfit();
      }
    } catch (e) {
      debugPrint('Error updating monthly expenses: $e');
    }
  }

  Future<void> updateDailyProfit() async {
    try {
      if (clinic != null &&
          clinic!.mDailyIncome != null &&
          clinic!.mDailyExpenses != null) {
        clinic!.mDailyProfit = clinic!.mDailyIncome! - clinic!.mDailyExpenses!;
        await updateMonthlyProfit();
      }
    } catch (e) {
      debugPrint('Error updating daily profit: $e');
    }
  }

  Future<void> updateMonthlyProfit() async {
    try {
      if (clinic != null &&
          clinic!.mMonthlyIncome != null &&
          clinic!.mMonthlyExpenses != null) {
        clinic!.mMonthlyProfit =
            clinic!.mMonthlyIncome! - clinic!.mMonthlyExpenses!;
        await updateClinic(clinic!);
      }
    } catch (e) {
      debugPrint('Error updating monthly profit: $e');
    }
  }
}
