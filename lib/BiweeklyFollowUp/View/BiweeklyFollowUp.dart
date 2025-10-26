import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/BiweeklyFollowUp/View/UsedWidgets/ActionButton.dart';
import 'package:vera_clinic/MonthlyFollowUpsDetailsPage/MonthlyFollowUpsDetailsPage.dart';

import '../../../Core/View/Reusable widgets/my_app_bar.dart';
import '../../Core/Model/Classes/Client.dart';
import '../Controller/BiweeklyFollowUpTEC.dart';
import 'UsedWidgets/LastFollowUpInfo.dart';
import 'UsedWidgets/newBiweeklyFollowUp.dart';

class BiweeklyFollowUp extends StatefulWidget {
  final Client client;
  const BiweeklyFollowUp({super.key, required this.client});

  @override
  State<BiweeklyFollowUp> createState() => _BiweeklyFollowUpState();
}

class _BiweeklyFollowUpState extends State<BiweeklyFollowUp> {
  late Future<ClientMonthlyFollowUp?> _lastMonthlyFollowUpFuture;

  @override
  void initState() {
    super.initState();
    BiweeklyFollowUpTEC.init();
    _lastMonthlyFollowUpFuture = _fetchLastClientMonthlyFollowUp();
  }

  @override
  void dispose() {
    BiweeklyFollowUpTEC.dispose();
    super.dispose();
  }

  Future<ClientMonthlyFollowUp?> _fetchLastClientMonthlyFollowUp() async {
    return await context
        .read<ClientMonthlyFollowUpProvider>()
        .getClientMonthlyFollowUpById(widget.client.mClientLastMonthlyFollowUpId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'متابعة أسبوعين: ${widget.client.mName!}',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyFollowUpsDetailsPage(
                      client: widget.client,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              icon: const Icon(Icons.calendar_month),
              label: const Text(
                'عرض المتابعات السابقة',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Background(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0)
                    .copyWith(top: 12),
                child: Column(
                  children: [
                    FutureBuilder<ClientMonthlyFollowUp?>(
                      future: _lastMonthlyFollowUpFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'حدث خطأ أثناء تحميل البيانات',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          final cmfu = snapshot.data!;
                          return Column(
                            children: [
                              LastFollowUpInfo(client: widget.client, cmfu: cmfu),
                              const SizedBox(height: 20),
                              newBiweeklyFollowUpForm(),
                            ],
                          );
                        } else {
                          return const Center(child: Text('لا توجد بيانات'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FutureBuilder<ClientMonthlyFollowUp?>(
                future: _lastMonthlyFollowUpFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cmfu = snapshot.data!;
                    return ActionButton(client: widget.client, cmfu: cmfu);
                  } else {
                    return const SizedBox(height: 60);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
