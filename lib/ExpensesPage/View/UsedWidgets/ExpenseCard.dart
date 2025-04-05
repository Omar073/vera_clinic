import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import '../../../Core/Model/Classes/Expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense? expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text(
            //   expense?.mName ?? 'اسم غير متوفر',
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   textDirection: TextDirection.rtl,
            // ),
            MyTextBox(
                title: 'اسم المصروف', value: expense?.mName ?? 'اسم غير متوفر'),
            const SizedBox(height: 8),
            MyTextBox(
                title: 'المبلغ',
                value: expense?.mAmount?.toStringAsFixed(2) ?? 'غير متوفر'),
            // Text(
            //   'المبلغ: ${expense?.mAmount?.toStringAsFixed(2) ?? 'غير متوفر'}',
            //   style: const TextStyle(fontSize: 16),
            //   textDirection: TextDirection.rtl,
            // ),
            const SizedBox(height: 8),
            MyTextBox(
                title: 'التاريخ',
                value:
                    '${expense?.mDate.day}/${expense?.mDate.month}/${expense?.mDate.year}'),
            // Text(
            //   'التاريخ: ${expense?.mDate.day}/${expense?.mDate.month}/${expense?.mDate.year}',
            //   style: const TextStyle(fontSize: 16),
            //   textDirection: TextDirection.rtl,
            // ),
          ],
        ),
      ),
    );
  }
}
