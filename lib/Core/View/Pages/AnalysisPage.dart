import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Clinic.dart';
import 'package:intl/intl.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  int getWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final daysSinceFirst = date.day + firstDayOfMonth.weekday - 1;
    return (daysSinceFirst / 7).ceil().clamp(1, 4);
  }

  String getDateText(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final String currentMonth = DateFormat('MMMM').format(currentDate);
    final int weekOfMonth = getWeekOfMonth(currentDate);
    String dayName = DateFormat('EEEE').format(currentDate);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 65,
            // width: MediaQuery.of(context).size.width,
            // color: Colors.blue[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BackButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: Text(
                    'Analysis Page\n$dayName: ${getDateText(currentDate)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 65,
            child: Row(
              children: [
                // Weekly Analysis Section
                Expanded(
                  child: Container(
                    color: Colors.blue[50], // Background color for clarity
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Week $weekOfMonth',
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
                        Text('الدخل اليوم: \$${clinic.mDailyIncome}'),
                        Text('عدد العملاء اليوم: ${clinic.mDailyPatients}'),
                        Text('الصاريف اليوم: \$${clinic.mDailyExpenses}'),
                        Text('الربح اليوم: \$${clinic.mDailyProfit}'),
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
                    color: Colors.green[50], // Background color for clarity
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          currentMonth, // Example month name
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Monthly Analysis',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text('الدخل الشهري: \$${clinic.mMonthlyIncome}'),
                        Text(
                            'عدد العملاء هذا الشهر: ${clinic.mMonthlyPatients}'),
                        Text('الصاريف هذا الشهر: \$${clinic.mMonthlyExpenses}'),
                        Text('الربح هذا الشهر: \$${clinic.mMonthlyProfit}'),
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
