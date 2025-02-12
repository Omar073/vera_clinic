import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import 'InfoCards/CheckInButton.dart';
import 'InfoCards/ClientInfoCard.dart';
import 'InfoCards/MeasurementsCard.dart';
import 'InfoCards/subscriptionCard.dart';

class CheckInPage extends StatefulWidget {
  final Client? client;
  const CheckInPage({super.key, required this.client});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  TextEditingController subscriptionPriceController = TextEditingController();
  late Future<void> _fetchData;

  Client? client;
  late ClientConstantInfo clientConstantInfo;
  late Visit lastClientVisit;

  @override
  void initState() {
    super.initState();
    client = widget.client;
    _fetchData = fetch();
  }

  Future<void> fetch() async {
    clientConstantInfo = (await context
        .read<ClientConstantInfoProvider>()
        .getClientConstantInfoByClientId(client!.mClientId))!;
    lastClientVisit = (await context
        .read<VisitProvider>()
        .getClientLastVisit(client!.mClientId))!;

    debugPrint(
        'Client Constant Info: ${clientConstantInfo.mClientConstantInfoId}');
    debugPrint('Last Client Visit: ${lastClientVisit.mVisitId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In: ${client?.mName}'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading client data'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        clientInfoCard(
                            client, clientConstantInfo, lastClientVisit),
                        const SizedBox(height: 24),
                        measurementsCard(client),
                        const SizedBox(height: 24),
                        SubscriptionCard(
                          client: client,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CheckInButton(
                        client: client,
                        subscriptionPriceController:
                            subscriptionPriceController),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
