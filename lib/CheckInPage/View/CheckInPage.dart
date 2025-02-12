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
  bool isLoading = true;
  String? errorMessage;

  Client? client;
  late ClientConstantInfo clientConstantInfo;
  late Visit lastClientVisit;

  @override
  void initState() {
    super.initState();
    client = widget.client;
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch client constant info
      final clientConstantInfoResult = await context
          .read<ClientConstantInfoProvider>()
          .getClientConstantInfoByClientId(client!.mClientId);

      // Fetch last visit
      final lastVisitResult = await context
          .read<VisitProvider>()
          .getClientLastVisit(client!.mClientId);

      if (clientConstantInfoResult == null || lastVisitResult == null) {
        throw Exception('Failed to load client data');
      }

      setState(() {
        clientConstantInfo = clientConstantInfoResult;
        lastClientVisit = lastVisitResult;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading client data: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Check In: ${client?.mName}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  clientInfoCard(client, clientConstantInfo, lastClientVisit),
                  const SizedBox(height: 24),
                  measurementsCard(client),
                  const SizedBox(height: 24),
                  SubscriptionCard(client: client),
                ],
              ),
              const SizedBox(height: 24),
              CheckInButton(
                client: client,
                subscriptionPriceController: subscriptionPriceController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
