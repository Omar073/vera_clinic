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
  @override
  void initState() {
    super.initState();
    // Load data once when the page initializes.
    Future.microtask(() {
      context.read<ClinicProvider>().getClinic();
      context.read<ExpenseProvider>().getAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clinicProvider = context.watch<ClinicProvider>();
    final expenseProvider = context.watch<ExpenseProvider>();

    final Clinic? clinic = clinicProvider.clinic;
    final List<Expense?> expenses = expenseProvider.cachedExpenses;

    final currentDate = DateTime.now();
    final String currentMonth = DateFormat('MMMM').format(currentDate);
    final int weekOfMonth = getWeekOfMonth(currentDate);
    String dayName = DateFormat('EEEE').format(currentDate);

    // Show a loading indicator if the clinic data is not yet available.
    if (clinic == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'البيانات\n$dayName: ${getDateText(currentDate)}',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue[50]!,
        centerTitle: true,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensesPage(expenses: expenses),
                ),
              );
            },
            child: const Text(
              'المصروفات',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: Row(
              children: [
                // Monthly Analysis Section
                Expanded(
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          currentMonth,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'البيانات الشهرية',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'الدخل الشهري: \$${clinic.mMonthlyIncome}\n'
                          'عدد العملاء هذا الشهر: ${clinic.mMonthlyPatients}\n'
                          'مصاريف هذا الشهر: \$${clinic.mMonthlyExpenses}\n'
                          'الربح هذا الشهر: \$${clinic.mMonthlyProfit}',
                          style: const TextStyle(fontSize: 20),
                        ),
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
                // Weekly Analysis Section
                Expanded(
                  child: Container(
                    color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'الاسبوع رقم $weekOfMonth',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'البيانات اليومية',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'الدخل اليوم: \$${clinic.mDailyIncome}\n'
                          'عدد العملاء اليوم: ${clinic.mDailyPatients}\n'
                          'مصاريف اليوم: \$${clinic.mDailyExpenses}\n'
                          'الربح اليوم: \$${clinic.mDailyProfit}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
