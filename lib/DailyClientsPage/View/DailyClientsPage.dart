import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import 'package:vera_clinic/DailyClientsPage/Controller/DailyClientsController.dart';
import 'package:vera_clinic/DailyClientsPage/View/DailyClientCard.dart';

import '../../Core/Controller/Providers/ClinicProvider.dart';

class DailyClientsPage extends StatefulWidget {
  const DailyClientsPage({super.key});

  @override
  State<DailyClientsPage> createState() => _DailyClientsPageState();
}

class _DailyClientsPageState extends State<DailyClientsPage> {
  late Future<List<Client?>> _dailyClientsFuture;
  final DailyClientsController _controller = DailyClientsController();

  @override
  void initState() {
    super.initState();
    _dailyClientsFuture = _controller.getDailyClients(context);
    context.read<ClinicProvider>().syncDailyClientsWithCheckedIn();
  }

  void _refreshClients() {
    setState(() {
      _dailyClientsFuture = _controller.getDailyClients(context);
      context.read<ClinicProvider>().syncDailyClientsWithCheckedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'قائمة عملاء اليوم',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshClients,
          ),
        ],
      ),
      body: Background(
        child: FutureBuilder<List<Client?>>(
          future: _dailyClientsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue[800],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'لا يوجد عملاء لليوم',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              final clients = snapshot.data!;
              return ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return client != null
                      ? DailyClientCard(
                          client: client,
                          index: index,
                          onClientRemoved: _refreshClients,
                        )
                      : const SizedBox.shrink();
                },
              );
            }
          },
        ),
      ),
    );
  }
} 