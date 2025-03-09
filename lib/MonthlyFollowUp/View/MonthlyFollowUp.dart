import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/MonthlyFollowUp/View/UsedWidgets/ActionButton.dart';

import '../../Core/Model/Classes/Client.dart';
import '../Controller/MonthlyFollowUpTEC.dart';
import 'UsedWidgets/infoField.dart';
import 'UsedWidgets/infoCard.dart';
import 'UsedWidgets/newMonthlyFollowUpForm.dart';

class MonthlyFollowUp extends StatefulWidget {
  final Client client;
  const MonthlyFollowUp({super.key, required this.client});

  @override
  State<MonthlyFollowUp> createState() => _MonthlyFollowUpState();
}

class _MonthlyFollowUpState extends State<MonthlyFollowUp> {
  @override
  void initState() {
    super.initState();
    MonthlyFollowUpTEC.initMonthlyFollowUpTEC();
  }

  @override
  void dispose() {
    MonthlyFollowUpTEC.disposeMonthlyFollowUpTEC();
    super.dispose();
  }

  Future<ClientMonthlyFollowUp?> _fetchLastMonthlyFollowUp() async {
    final cmfu = await context
        .read<ClientMonthlyFollowUpProvider>()
        .getClientMonthlyFollowUpByClientId(widget.client.mClientId);
    return cmfu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.client.mName!} :متابعة شهرية, عميل '),
          centerTitle: true,
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<ClientMonthlyFollowUp?>(
                    future: _fetchLastMonthlyFollowUp(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('حدث خطأ ما'));
                      }
                      if (snapshot.hasData) {
                        final cmfu = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: infoCard(
                                "تفاصيل المتابعة الشهرية السابقة",
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: infoField(
                                            title: "BMI", value: "${cmfu.mBMI}")),
                                    Expanded(
                                        child: infoField(
                                            title: "PBF", value: "${cmfu.mPBF}")),
                                    Expanded(
                                        child: infoField(
                                            title: "BMR", value: "${cmfu.mBMR}")),
                                    Expanded(
                                        child: infoField(
                                            title: "Water",
                                            value: "${cmfu.mWater}")),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: infoCard(
                                "تفاصيل المتابعة الشهرية السابقة",
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: infoField(
                                            title: "Max weight",
                                            value: "${cmfu.mMaxWeight}")),
                                    Expanded(
                                        child: infoField(
                                            title: "Optimal weight",
                                            value: "${cmfu.mOptimalWeight}")),
                                    Expanded(
                                        child: infoField(
                                            title: "Max calories",
                                            value: "${cmfu.mMaxCalories}")),
                                    Expanded(
                                        child: infoField(
                                            title: "Daily calories",
                                            value: "${cmfu.mDailyCalories}")),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(child: Text('لا توجد بيانات'));
                      }
                    }),
                const SizedBox(height: 20),
                newMonthlyFollowUpForm(),
                const SizedBox(height: 20),
                ActionButton(client: widget.client),
              ],
            ),
          ),
        ));
  }
}
