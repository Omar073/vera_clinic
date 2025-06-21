import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';

import '../../../Core/Controller/Providers/ClinicProvider.dart';

class DailyClientsController {
  Future<List<Client?>> getDailyClients(BuildContext context) async {
    final clinicProvider = context.read<ClinicProvider>();
    final clientProvider = context.read<ClientProvider>();

    // Fetch the latest clinic data
    await context.read<ClinicProvider>().getClinic();

    final dailyClientIds = clinicProvider.clinic?.mDailyClientIds ?? [];
    
    if (dailyClientIds.isEmpty) {
      return [];
    }

    List<Client?> dailyClients = [];
    for (var clientId in dailyClientIds) {
      final client = await clientProvider.getClientById(clientId);
      if (client != null) {
        dailyClients.add(client);
      }
    }

    return dailyClients;
  }
} 