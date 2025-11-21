import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/BiweeklyFollowUp/View/UsedWidgets/ActionButton.dart';
import 'package:vera_clinic/MonthlyFollowUpsDetailsPage/MonthlyFollowUpsDetailsPage.dart';

import '../../../Core/View/Reusable widgets/my_app_bar.dart';
import '../../Core/Model/Classes/Client.dart';
import '../Controller/BiweeklyFollowUpTEC.dart';
import 'UsedWidgets/BiweeklyInbodyGrid.dart';

class BiweeklyFollowUp extends StatefulWidget {
  final Client client;
  const BiweeklyFollowUp({super.key, required this.client});

  @override
  State<BiweeklyFollowUp> createState() => _BiweeklyFollowUpState();
}

class _BiweeklyFollowUpState extends State<BiweeklyFollowUp> {
  late Future<List<ClientMonthlyFollowUp>> _clientMonthlyFollowUpsFuture;

  @override
  void initState() {
    super.initState();
    BiweeklyFollowUpTEC.init();
    _clientMonthlyFollowUpsFuture = _fetchClientMonthlyFollowUps();
  }

  @override
  void dispose() {
    BiweeklyFollowUpTEC.dispose();
    super.dispose();
  }

  Future<List<ClientMonthlyFollowUp>> _fetchClientMonthlyFollowUps() async {
    final provider = context.read<ClientMonthlyFollowUpProvider>();
    final List<ClientMonthlyFollowUp> fetched =
        await provider.getClientMonthlyFollowUps(widget.client.mClientId);

    // Sort by date descending (newest first), falling back to epoch for nulls.
    fetched.sort((a, b) {
      final da = a.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      final db = b.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      return db.compareTo(da);
    });

    return fetched;
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
                    FutureBuilder<List<ClientMonthlyFollowUp>>(
                      future: _clientMonthlyFollowUpsFuture,
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
                        if (!snapshot.hasData) {
                          return const Center(child: Text('لا توجد بيانات'));
                        }

                        final allFollowUps = snapshot.data!;
                        // Select up to three most relevant CMFUs based on business rule:
                        // first ever, second-to-last, and last, ensuring uniqueness.
                        final List<ClientMonthlyFollowUp> sortedAsc = [
                          ...allFollowUps
                        ];
                        sortedAsc.sort((a, b) {
                          final da = a.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
                          final db = b.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
                          return da.compareTo(db);
                        });

                        final List<ClientMonthlyFollowUp> previousForGrid = [];
                        if (sortedAsc.isNotEmpty) {
                          previousForGrid.add(sortedAsc.first);
                        }
                        if (sortedAsc.length > 2) {
                          final secondToLast = sortedAsc[sortedAsc.length - 2];
                          if (!previousForGrid
                              .any((c) => c.mClientMonthlyFollowUpId == secondToLast.mClientMonthlyFollowUpId)) {
                            previousForGrid.add(secondToLast);
                          }
                        }
                        if (sortedAsc.length > 1) {
                          final last = sortedAsc.last;
                          if (!previousForGrid
                              .any((c) => c.mClientMonthlyFollowUpId == last.mClientMonthlyFollowUpId)) {
                            previousForGrid.add(last);
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Top client summary row
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 12.0),
                                  child: Row(
                                    // In RTL, start = right, so this keeps all
                                    // text visually aligned to the right side.
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.client.mName ?? 'بدون اسم',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(width: 24),
                                      Text(
                                        'العمر: ${getAge(widget.client.mBirthdate)}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(width: 24),
                                      Text(
                                        'الطول: ${widget.client.mHeight?.toStringAsFixed(0) ?? 'غير معروف'} سم',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            BiweeklyInbodyGrid(
                              client: widget.client,
                              previousFollowUps: previousForGrid,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FutureBuilder<List<ClientMonthlyFollowUp>>(
                future: _clientMonthlyFollowUpsFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox(height: 60);
                  }
                  // Use the latest CMFU for the action button.
                  final latestCmfu = snapshot.data!.first;
                  return ActionButton(client: widget.client, cmfu: latestCmfu);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
