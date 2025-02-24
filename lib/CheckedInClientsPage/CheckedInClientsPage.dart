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
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    try {
      widget.checkedInClients =
          await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checked In Clients'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _fetchDataFuture = fetchData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading client details'));
          } else {
            // todo: understand why we used a consumer inside a future builder and why the future builder alone wasn't enough and why we needed to create a private variable for the future and assign it to fetchData() and call it in the future builder
            return Consumer<ClinicProvider>(
              builder: (context, clinicProvider, child) {
                if (clinicProvider.checkedInClients.isEmpty) {
                  return const Center(
                    child: Text('No clients checked in'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Expanded(
                          child: CheckedInClientsList(
                            checkInClients: clinicProvider.checkedInClients,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
