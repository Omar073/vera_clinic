import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Core/Controller/Providers/ExpenseProvider.dart';
import '../../../Core/Model/Classes/Expense.dart';
import 'ExpenseCard.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Expense?> expenses = context.watch<ExpenseProvider>().cachedExpenses;

    // Sort expenses by date in descending order
    final sortedExpenses = List<Expense?>.from(expenses)
      ..sort((a, b) => b!.mDate.compareTo(a!.mDate));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sortedExpenses.length,
      itemBuilder: (context, index) {
        return ExpenseCard(expense: sortedExpenses[index]);
      },
    );
  }
}