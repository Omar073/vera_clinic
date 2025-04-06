import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/ExpensesPage/Controller/NewExpenseUF.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => deleteExpense(expense!, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('حذف', style: TextStyle(color: Colors.white),),
            ),
            Column(
              children: [
                MyTextBox(
                    title: 'اسم المصروف',
                    value: expense?.mName ?? 'اسم غير متوفر'),
                const SizedBox(height: 8),
                MyTextBox(
                    title: 'المبلغ',
                    value: expense?.mAmount?.toStringAsFixed(2) ?? 'غير متوفر'),
                const SizedBox(height: 8),
                MyTextBox(
                    title: 'التاريخ',
                    value:
                        '${expense?.mDate.day}/${expense?.mDate.month}/${expense?.mDate.year}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
