import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../Controller/CheckInPageTEC.dart';
import 'InfoCards/CheckInButton.dart';
import 'InfoCards/ClientInfoCard.dart';
import 'InfoCards/MeasurementsCard.dart';
import 'InfoCards/SubscriptionCard.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';

import '../../Core/Services/DebugLoggerService.dart';
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
    if (client != null) {
      // Fetch constant info
      final clientConstantInfoResult = await context
          .read<ClientConstantInfoProvider>()
          .getClientConstantInfoByClientId(client!.mClientId);

      // Fetch last visit
      if (client?.mLastVisitId != null) {
        final lastVisitResult = await context
            .read<VisitProvider>()
            .getVisit(client!.mLastVisitId!);

        if (lastVisitResult != null) {
          lastClientVisit = lastVisitResult;
        }
      }

      mDebug(
          'Client Constant Info: ${clientConstantInfoResult?.mClientConstantInfoId}');
      mDebug('Last Client Visit: ${lastClientVisit?.mVisitId}');

      if (clientConstantInfoResult?.mClientConstantInfoId == null) {
        throw Exception('Failed to load client data');
      }

      setState(() {
        clientConstantInfo = clientConstantInfoResult;
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = 'لا يمكن تحميل بيانات العميل لأنه لم يتم تحديده.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'تسجيل لدخول: ${client?.mName ?? ''}',
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent))
              : errorMessage != null
                  ? Center(
                      child: Text(
                        errorMessage!,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
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
                                    lastClientVisit),
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
                                const SizedBox(height: 24),
                                // Check-in time input with AM/PM buttons
                                Center(
                                  child: Container(
                                    width: 300, // Fixed width instead of full width
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MyInputField(
                                            myController: CheckInPageTEC.checkInTimeController,
                                            hint: "HH:MM",
                                            label: "وقت تسجيل الدخول",
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  CheckInPageTEC.isAM = true;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: CheckInPageTEC.isAM ? Colors.blueAccent : Colors.white,
                                                foregroundColor: CheckInPageTEC.isAM ? Colors.white : Colors.grey[600],
                                                side: BorderSide(
                                                  color: CheckInPageTEC.isAM ? Colors.blueAccent : Colors.grey[400]!,
                                                  width: CheckInPageTEC.isAM ? 2 : 1,
                                                ),
                                                elevation: CheckInPageTEC.isAM ? 4 : 1,
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                minimumSize: const Size(60, 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'صباحاً', 
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: CheckInPageTEC.isAM ? FontWeight.bold : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  CheckInPageTEC.isAM = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: !CheckInPageTEC.isAM ? Colors.blueAccent : Colors.white,
                                                foregroundColor: !CheckInPageTEC.isAM ? Colors.white : Colors.grey[600],
                                                side: BorderSide(
                                                  color: !CheckInPageTEC.isAM ? Colors.blueAccent : Colors.grey[400]!,
                                                  width: !CheckInPageTEC.isAM ? 2 : 1,
                                                ),
                                                elevation: !CheckInPageTEC.isAM ? 4 : 1,
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                minimumSize: const Size(60, 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'مساءً', 
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: !CheckInPageTEC.isAM ? FontWeight.bold : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
                            checkInTimeController:
                                CheckInPageTEC.checkInTimeController,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
