import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      widget.checkedInClients =
          await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      debugPrint('Error getting checked-in clients: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      appBar: AppBar(
        title: const Text('قائمة العملاء في العيادة'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
                  if (context.read<ClinicProvider>().checkedInClients.isEmpty) {
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 100),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          CheckedInClientsList(
                            checkInClients:
                                context.read<ClinicProvider>().checkedInClients,
                            onClientCheckedOut: _handleClientCheckedOut,
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
