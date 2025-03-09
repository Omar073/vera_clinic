import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../Controller/CheckInPageTEC.dart';
import 'InfoCards/CheckInButton.dart';
import 'InfoCards/ClientInfoCard.dart';
import 'InfoCards/MeasurementsCard.dart';
import 'InfoCards/SubscriptionCard.dart';

class CheckInPage extends StatefulWidget {
  final Client? client;
  const CheckInPage({super.key, required this.client});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool isLoading = true;
  String? errorMessage;
  Client? client;
  ClientConstantInfo? clientConstantInfo;
  Visit? lastClientVisit;

  @override
  void initState() {
    super.initState();
    client = widget.client;
    _fetchData();
    CheckInPageTEC.init();
  }

  @override
  void dispose() {
    CheckInPageTEC.dispose();
    super.dispose();
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

      debugPrint(
          'Client Constant Info: ${clientConstantInfoResult?.mClientConstantInfoId}');
      debugPrint('Last Client Visit: ${lastVisitResult?.mVisitId}');

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In: ${client?.mName ?? ''}'),
        centerTitle: true,
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
                  ? Center(
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                clientInfoCard(client, clientConstantInfo!,
                                    lastClientVisit!),
                                const SizedBox(height: 24),
                                measurementsCard(client),
                                const SizedBox(height: 24),
                                SubscriptionCard(
                                  client: client,
                                  visitSubscriptionTypeController:
                                      CheckInPageTEC
                                          .visitSubscriptionTypeController,
                                  visitSubscriptionPriceController:
                                      CheckInPageTEC
                                          .visitSubscriptionPriceController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: CheckInButton(
                            client: client,
                            visitSubscriptionTypeController:
                                CheckInPageTEC.visitSubscriptionTypeController,
                            visitSubscriptionPriceController:
                                CheckInPageTEC.visitSubscriptionPriceController,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
