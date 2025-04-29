import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';
import 'package:vera_clinic/MonthlyFollowUp/View/UsedWidgets/ActionButton.dart';

import '../../Core/Model/Classes/Client.dart';
import '../Controller/MonthlyFollowUpTEC.dart';
import 'UsedWidgets/newMonthlyFollowUpForm.dart';

class MonthlyFollowUp extends StatefulWidget {
  final Client client;
  const MonthlyFollowUp({super.key, required this.client});

  @override
  State<MonthlyFollowUp> createState() => _MonthlyFollowUpState();
}

class _MonthlyFollowUpState extends State<MonthlyFollowUp> {
  late Future<ClientMonthlyFollowUp?> _lastMonthlyFollowUpFuture;

  @override
  void initState() {
    super.initState();
    MonthlyFollowUpTEC.initMonthlyFollowUpTEC();
    _lastMonthlyFollowUpFuture = _fetchLastMonthlyFollowUp();
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
        surfaceTintColor: Colors.white,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: myCard(
                              "تفاصيل المتابعة الشهرية السابقة",
                              Wrap(
                                alignment: WrapAlignment.start,
                                textDirection: TextDirection.rtl,
                                spacing: 40,
                                runSpacing: 20,
                                children: [
                                  MyTextBox(
                                    title: "مؤشر كتلة الجسم",
                                    value: "${cmfu.mBMI}",
                                  ),
                                  MyTextBox(
                                    title: "نسبة الدهون",
                                    value: "${cmfu.mPBF}",
                                  ),
                                  MyTextBox(
                                    title: "حد الحرق الأدني",
                                    value: "${cmfu.mBMR}",
                                  ),
                                  MyTextBox(
                                    title: "الماء",
                                    value: "${cmfu.mWater}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: myCard(
                              "تفاصيل المتابعة الشهرية السابقة",
                              Wrap(
                                alignment: WrapAlignment.start,
                                textDirection: TextDirection.rtl,
                                spacing: 40,
                                runSpacing: 20,
                                children: [
                                  MyTextBox(
                                    title: "أقصي وزن",
                                    value: "${cmfu.mMaxWeight}",
                                  ),
                                  MyTextBox(
                                    title: "الوزن المثالي",
                                    value: "${cmfu.mOptimalWeight}",
                                  ),
                                  MyTextBox(
                                    title: "أقصي سعرات",
                                    value: "${cmfu.mMaxCalories}",
                                  ),
                                  MyTextBox(
                                    title: "السعرات اليومية",
                                    value: "${cmfu.mDailyCalories}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          newMonthlyFollowUpForm(),
                          const SizedBox(height: 50),
                          ActionButton(client: widget.client, cmfu: cmfu),
                          const SizedBox(height: 20),
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
