import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Clinic.dart';
import 'package:intl/intl.dart';
import 'package:vera_clinic/ExpensesPage/View/ExpensesPage.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Controller/UtilityFunctions.dart';
import '../Core/Model/Classes/Expense.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  Clinic? clinic;
  List<Expense?> expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchClinicData();
  }

  Future<void> _fetchClinicData() async {
    try {
      clinic = await context.read<ClinicProvider>().getClinic();
      expenses = await context.read<ExpenseProvider>().getAllExpenses();
    } catch (e) {
      debugPrint('Error fetching clinic data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final String currentMonth = DateFormat('MMMM').format(currentDate);
    final int weekOfMonth = getWeekOfMonth(currentDate);
    String dayName = DateFormat('EEEE').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Page\n$dayName: ${getDateText(currentDate)}'),
        backgroundColor: Colors.blue[50]!,
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpensesPage(
                              expenses: expenses,
                            )));
              },
              child: const Text(
                'المصروفات',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(width: 10),
        ],
      ),
      body: FutureBuilder<void>(
          future: _fetchClinicData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  const Divider(),
                  Expanded(
                    child: Row(
                      children: [
                        // Weekly Analysis Section
                        Expanded(
                          child: Container(
                            color:
                                Colors.blue[50], // Background color for clarity
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  'Week $weekOfMonth',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'البيانات اليومية',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                // Text('الدخل اليوم: \$${clinic.mDailyIncome}'),
                                // Text('عدد العملاء اليوم: ${clinic.mDailyPatients}'),
                                // Text('الصاريف اليوم: \$${clinic.mDailyExpenses}'),
                                // Text('الربح اليوم: \$${clinic.mDailyProfit}'),
                              ],
                            ),
                          ),
                        ),
                        // Vertical Divider
                        const VerticalDivider(
                          width: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        // Monthly Analysis Section
                        Expanded(
                          child: Container(
                            color: Colors
                                .green[50], // Background color for clarity
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  currentMonth, // Example month name
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Monthly Analysis',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                // Text('الدخل الشهري: \$${clinic.mMonthlyIncome}'),
                                // Text(
                                //     'عدد العملاء هذا الشهر: ${clinic.mMonthlyPatients}'),
                                // Text('الصاريف هذا الشهر: \$${clinic.mMonthlyExpenses}'),
                                // Text('الربح هذا الشهر: \$${clinic.mMonthlyProfit}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
