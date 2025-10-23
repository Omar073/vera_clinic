import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import 'CheckedInClientsList.dart';

class CheckedInClientsPage extends StatefulWidget {
  const CheckedInClientsPage({super.key});

  @override
  State<CheckedInClientsPage> createState() => _CheckedInClientsPageState();
}

class _CheckedInClientsPageState extends State<CheckedInClientsPage>
    with WidgetsBindingObserver {
  Future<void>? _fetchDataFuture;
  bool _isLoading = false;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchDataFuture = fetchData();
    _startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPolling();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _startPolling();
      _handleClientCheckedOut(); // Refresh data when app comes to foreground
    } else {
      _stopPolling();
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel(); // Cancel any existing timer
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _pollForUpdates();
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
  }

  Future<void> _pollForUpdates() async {
    try {
      // The provider will notify listeners, and the Consumer will rebuild.
      await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      debugPrint('Error polling for checked-in clients: $e');
      if (mounted) {
        showMySnackBar(
            context, 'خطأ في التحديث التلقائي: ${e.toString()}', Colors.orange);
      }
    }
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      // The provider will notify listeners, and the Consumer will rebuild.
      await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
      if (mounted) {
        showMySnackBar(
            context, 'فشل تحميل القائمة: ${e.toString()}', Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleClientCheckedOut() {
    setState(() {
      _fetchDataFuture = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'قائمة العملاء في العيادة',
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _fetchDataFuture = fetchData();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                ),
        ],
      ),
      body: Background(
        child: FutureBuilder<void>(
          future: _fetchDataFuture,
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
                    final notArrived = checkedInClients
                        .where((c) => !(clinicProvider.clinic
                                ?.hasClientArrived(c?.mClientId ?? '') ??
                            false))
                        .toList();
                    final arrived = checkedInClients
                        .where((c) =>
                            clinicProvider.clinic
                                ?.hasClientArrived(c?.mClientId ?? '') ??
                            false)
                        .toList();

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
                                  onClientCheckedOut: _handleClientCheckedOut,
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
                                  onClientCheckedOut: _handleClientCheckedOut,
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
