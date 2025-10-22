import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/CustomExceptions.dart';

import '../../../Core/Controller/Providers/ClinicProvider.dart';

class DailyClientsController {
  Future<List<Client?>> getDailyClients(BuildContext context) async {
    final clinicProvider = context.read<ClinicProvider>();
    final clientProvider = context.read<ClientProvider>();

    // Fetch the latest clinic data; rely on fast-fail from fetchClinic for missing docs
    await context.read<ClinicProvider>().getClinic();
    if (clinicProvider.clinic == null) {
      // Surface a meaningful error when clinic data is not found
      throw FirebaseOperationException('لم يتم العثور على بيانات العيادة.');
    }

    final dailyClientIds = clinicProvider.clinic?.mDailyClientIds ?? [];
    
    if (dailyClientIds.isEmpty) {
      return [];
    }

    List<Client?> dailyClients = [];
    for (var clientId in dailyClientIds) {
      // Timebox each client fetch to ensure overall UI responsiveness
      final client = await clientProvider
          .getClientById(clientId)
          .timeout(const Duration(seconds: 3), onTimeout: () => null);
      if (client != null) {
        dailyClients.add(client);
      }
    }

    return dailyClients;
  }
} 