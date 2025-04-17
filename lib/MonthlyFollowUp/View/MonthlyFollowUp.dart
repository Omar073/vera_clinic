import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.client.mName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(' :متابعة شهرية'),
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder<ClientMonthlyFollowUp?>(
                  future: _fetchLastMonthlyFollowUp(),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: infoCard(
                              "تفاصيل المتابعة الشهرية السابقة",
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: infoField(
                                      title: "مؤشر كتلة الجسم",
                                      value: "${cmfu.mBMI}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "نسبة الدهون",
                                      value: "${cmfu.mPBF}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "حد الحرق الأدني",
                                      value: "${cmfu.mBMR}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "الماء",
                                      value: "${cmfu.mWater}",
                                    ),
                                  ),
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
                                      title: "أقصي وزن",
                                      value: "${cmfu.mMaxWeight}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "الوزن المثالي",
                                      value: "${cmfu.mOptimalWeight}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "أقصي سعرات",
                                      value: "${cmfu.mMaxCalories}",
                                    ),
                                  ),
                                  Expanded(
                                    child: infoField(
                                      title: "السعرات اليومية",
                                      value: "${cmfu.mDailyCalories}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          newMonthlyFollowUpForm(),
                          const SizedBox(height: 70),
                          ActionButton(client: widget.client, cmfu: cmfu),
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
      ),
    );
  }
}
