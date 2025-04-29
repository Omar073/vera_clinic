import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/ExpensesPage/Controller/ExpensesPageUF.dart';
import '../../../Core/Model/Classes/Expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense? expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => deleteExpense(expense!, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
              ),
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text(
                'حذف',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Wrap(
                    children: [MyTextBox(
                        title: 'اسم المصروف',
                        value: expense?.mName ?? 'اسم غير متوفر'),]
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [MyTextBox(
                        title: 'المبلغ',
                        value: expense?.mAmount?.toStringAsFixed(2) ??
                            'غير متوفر'),]
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [MyTextBox(
                        title: 'التاريخ',
                        value:
                            '${expense?.mDate.day}/${expense?.mDate.month}/${expense?.mDate.year}'),]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
