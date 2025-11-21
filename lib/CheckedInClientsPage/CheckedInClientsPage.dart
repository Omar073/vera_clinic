import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Model/Classes/Clinic.dart';
import '../Core/Model/Classes/Client.dart';
import 'CheckedInClientsList.dart';
import 'Controller/CheckedInClientsPageUF.dart';

class CheckedInClientsPage extends StatefulWidget {
  const CheckedInClientsPage({super.key});

  @override
  State<CheckedInClientsPage> createState() => _CheckedInClientsPageState();
}

class _CheckedInClientsPageState extends State<CheckedInClientsPage> {
  late CheckedInClientsLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = CheckedInClientsLogic(
      context: context,
      onRefreshRequested: () {
        if (mounted) setState(() {});
      },
    );
    _logic.init();
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'قائمة العملاء في العيادة',
        actions: [
          // Test button for audio (temporary debugging)
          IconButton(
            onPressed: () {
              _logic.testArrivalSound();
            },
            icon: const Icon(Icons.volume_up),
            tooltip: 'Test Sound',
          ),
          _logic.isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    _logic.startManualRefresh();
                  },
                  icon: const Icon(Icons.refresh),
                ),
        ],
      ),
      body: Background(
        child: FutureBuilder<void>(
          future: _logic.fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Background(
                      child: Center(
                          child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ))));
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Background(
                  child: Center(
                    child: Text(
                      'حدث خطأ أثناء تحميل البيانات',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            } else {
              // todo: understand why we used a consumer inside a future builder
              //*  and why the future builder alone wasn't enough and why we
              //*  needed to create a private variable for the future and assign
              //*  it to fetchData() and call it in the future builder
              return Consumer<ClinicProvider>(
                builder: (context, clinicProvider, child) {
                  final checkedInClients = clinicProvider.checkedInClients;
                  if (checkedInClients.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      ' لا يوجد عملاء ... يمكنك الضغط على زر التحديث '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.refresh,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: ' أعلى اليمين للبحث عن عملاء جدد '),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Split clients by arrival status
                    final Clinic? clinic = clinicProvider.clinic;
                    bool clientHasArrived(Client? client) {
                      if (clinic == null) return false;
                      return clinic.hasClientArrived(client?.mClientId ?? '');
                    }

                    final notArrived =
                        checkedInClients.where((c) => !clientHasArrived(c)).toList();
                    final arrived =
                        checkedInClients.where(clientHasArrived).toList();

                    _logic.handleArrivalNotifications(arrived);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Right side: Arrived
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'وصلوا',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                CheckedInClientsList(
                                  checkInClients: arrived,
                                  onClientCheckedOut: _logic.startManualRefresh,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          // Left side: Not Arrived
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'لم يصلوا بعد',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                CheckedInClientsList(
                                  checkInClients: notArrived,
                                  onClientCheckedOut: _logic.startManualRefresh,
                                ),
                              ],
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
      ),
    );
  }

}
