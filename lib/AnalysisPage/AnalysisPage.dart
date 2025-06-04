import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/ExpensesPage/View/ExpensesPage.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Controller/UtilityFunctions.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  bool _isLoading = true;
  final TextEditingController _deductionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _deductionController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      await context.read<ClinicProvider>().getClinic();
      await context.read<ExpenseProvider>().getAllExpenses();
    } catch (e) {
      debugPrint('Error loading data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildDeductionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'إدارة الدخل اليومي',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: MyInputField(
                  myController: _deductionController,
                  label: 'خصم من الدخل اليومي',
                  hint: 'أدخل المبلغ',
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final double amountStr = double.parse(_deductionController.text);
                  await context
                      .read<ClinicProvider>()
                      .updateDailyIncome(-amountStr);
                  debugPrint('Deducting: $amountStr');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                ),
                label: const Text('خصم'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clinic = context.watch<ClinicProvider>().clinic;
    final expenses = context.watch<ExpenseProvider>().cachedExpenses;

    final currentDate = DateTime.now();
    final String currentMonth =
        intl.DateFormat('MMMM', 'ar').format(currentDate);
    final int weekOfMonth = getWeekOfMonth(currentDate);
    String dayName = intl.DateFormat('EEEE', 'ar').format(currentDate);

    if (_isLoading || clinic == null) {
      return const Scaffold(
        body: Background(
            child: Center(
                child: CircularProgressIndicator(color: Colors.blueAccent))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'البيانات\n$dayName: ${getDateText(currentDate)}',
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 208, 241, 255),
        surfaceTintColor: const Color.fromARGB(255, 208, 241, 255),
        toolbarHeight: 70,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await _loadData();
            },
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Monthly Analysis Section
                  Expanded(
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
                          '${clinic.mMonthlyIncome! < 0 ? '-' : ''}'
                          '${clinic.mMonthlyIncome!.abs().toStringAsFixed(2)}\$ :الدخل الشهري\n'
                          '${clinic.mMonthlyPatients!.abs()} :عدد العملاء هذا الشهر\n'
                          '${clinic.mMonthlyExpenses! < 0 ? '-' : ''}'
                          '${clinic.mMonthlyExpenses!.abs().toStringAsFixed(2)}\$ :مصاريف هذا الشهر\n'
                          '${clinic.mMonthlyProfit! < 0 ? '-' : ''}'
                          '${clinic.mMonthlyProfit!.abs().toStringAsFixed(2)}\$ :الربح هذا الشهر\n',
                          style: const TextStyle(
                            fontSize: 20,
                            height: 2.0,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
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
                          '${clinic.mDailyIncome! < 0 ? '-' : ''}'
                          '${clinic.mDailyIncome!.abs().toStringAsFixed(2)}\$ :الدخل اليوم\n'
                          '${clinic.mDailyPatients!.abs()} :عدد العملاء اليوم\n'
                          '${clinic.mDailyExpenses! < 0 ? '-' : ''}'
                          '${clinic.mDailyExpenses!.abs().toStringAsFixed(2)}\$ :مصاريف اليوم\n'
                          '${clinic.mDailyProfit! < 0 ? '-' : ''}'
                          '${clinic.mDailyProfit!.abs().toStringAsFixed(2)}\$ :الربح اليوم',
                          style: const TextStyle(fontSize: 20, height: 2.0),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildDeductionSection(),
          ],
        ),
      ),
    );
  }
}
