import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/VisitActionButton.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/visitInfo1.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/visitInfo2.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/VisitTEC.dart';
import 'UsedWidgets/visitClientInfoCard.dart';

class WeeklyFollowUp extends StatefulWidget {
  final Client client;
  const WeeklyFollowUp({super.key, required this.client});

  @override
  State<WeeklyFollowUp> createState() => _WeeklyFollowUpState();
}

class _WeeklyFollowUpState extends State<WeeklyFollowUp> {
  late Future<Visit?> _lastVisitDate;

  @override
  void initState() {
    super.initState();
    _lastVisitDate = _fetchLastVisitDate();
    WeeklyFollowUpTEC.init();
  }

  @override
  void dispose() {
    WeeklyFollowUpTEC.dispose();
    super.dispose();
  }

  Future<Visit?> _fetchLastVisitDate() async {
    final visit = await context
        .read<VisitProvider>()
        .getClientLastVisit(widget.client.mClientId);
    return visit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.client.mName!} :متابعة اسبوعية, عميل '),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            visitClientInfoCard(widget.client),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: myCard(
                "اخر متابعة",
                FutureBuilder<Visit?>(
                  future: _lastVisitDate,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        "نظام اخر متابعة: جاري التحميل...",
                        style: TextStyle(fontSize: 20),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        "نظام اخر متابعة: خطأ",
                        style: TextStyle(fontSize: 20),
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Wrap(
                            spacing: 60,
                            children: [
                              Text(
                                "${snapshot.data?.mDiet ?? 'لا يوجد نظام متابعة'} :نظام اخر متابعة ",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "وزن اخر متابعة: ${snapshot.data?.mWeight ?? 'لا يوجد وزن متابعة'}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "تاريخ اخر متابعة: ${snapshot.data?.mDate.toLocal().toString().split(' ')[0] ?? 'لا يوجد تاريخ متابعة'}",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            visitInfo1(),
            const SizedBox(height: 20),
            visitInfo2(),
            const SizedBox(height: 30),
            VisitActionButton(client: widget.client),
          ],
        ),
      )),
    );
  }
}
