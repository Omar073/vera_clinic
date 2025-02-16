import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/UtilityFunctions.dart';

import '../../Core/Controller/Providers/ClientProvider.dart';
import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';

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
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: myCard(
                "متابعة اسبوعية",
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Wrap(
                        spacing: 60,
                        children: [
                          Text(
                              "${widget.client.mDiet ?? 'No Diet'} :إسم النظام الحالي ",
                              style: const TextStyle(fontSize: 20)),
                          Text("الوزن: ${widget.client.mWeight ?? 'No weight'}",
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            'السن: ${getAge(widget.client.mBirthdate) ?? 'No age'}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${widget.client.mName ?? 'No name'} :الإسم',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: myCard(
              "اخر متابعة",
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 60,
                    children: [
                      FutureBuilder<Visit?>(
                        future: _lastVisitDate,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "نظام اخر متابعة: Loading...",
                              style: TextStyle(fontSize: 20),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              "نظام اخر متابعة: Error",
                              style: TextStyle(fontSize: 20),
                            );
                          } else {
                            return Text(
                              "${snapshot.data?.mDiet ?? 'No last visit diet'} :نظام اخر متابعة ",
                              style: const TextStyle(fontSize: 20),
                            );
                          }
                        },
                      ),
                      FutureBuilder<Visit?>(
                        future: _lastVisitDate,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "وزن اخر متابعة: Loading...",
                              style: TextStyle(fontSize: 20),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              "وزن اخر متابعة: Error",
                              style: TextStyle(fontSize: 20),
                            );
                          } else {
                            return Text(
                              "وزن اخر متابعة: ${snapshot.data?.mWeight ?? 'No last visit weight'}",
                              style: const TextStyle(fontSize: 20),
                            );
                          }
                        },
                      ),
                      FutureBuilder<Visit?>(
                        future: _lastVisitDate,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "تاريخ اخر متابعة: Loading...",
                              style: TextStyle(fontSize: 20),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              "تاريخ اخر متابعة: Error",
                              style: TextStyle(fontSize: 20),
                            );
                          } else {
                            return Text(
                              "تاريخ اخر متابعة: ${snapshot.data?.mDate.toLocal().toString().split(' ')[0] ?? 'No last visit date'}",
                              style: const TextStyle(fontSize: 20),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
