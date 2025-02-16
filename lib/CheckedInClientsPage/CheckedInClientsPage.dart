import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Model/Classes/Client.dart';
import 'CheckedInClientsList.dart';

class CheckedInClientsPage extends StatefulWidget {
  List<Client?> checkedInClients;
  CheckedInClientsPage({super.key, required this.checkedInClients});

  @override
  State<CheckedInClientsPage> createState() => _CheckedInClientsPageState();
}

class _CheckedInClientsPageState extends State<CheckedInClientsPage> {
  // List<Client?> checkedInClients = [];

  @override
  void initState() {
    super.initState();
    // print ids of all checked in clients
    for (var c in widget.checkedInClients) {
      debugPrint('Checked in client id: ${c?.mClientId}');
    }
    // Fetch the checked-in clients list
    // getCheckedInClients();
  }

  Future<void> getCheckedInClients() async {
    try {
      widget.checkedInClients =
          await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
    }
  }

//! I am thinking of using both watch and read of provider, initially use read to fetch the value of the checked-in clients then use watch to keep track of any changes, unless I can replace that by using only watch and initialize the list using another method like when the initial button from the home page is pressed?

  @override
  Widget build(BuildContext context) {
    widget.checkedInClients =
        context.watch<ClinicProvider>().checkedInClients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checked In Clients'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                getCheckedInClients();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CheckedInClientsList(checkInClients: widget.checkedInClients),
          ],
        ),
      ),
    );
  }
}



// Widget clientCard(Client client) {} //stful
