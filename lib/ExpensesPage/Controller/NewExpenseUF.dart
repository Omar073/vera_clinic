import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';

import '../../Core/Controller/Providers/ClinicProvider.dart';
import '../../Core/Model/Classes/Expense.dart';
import 'NewExpenseTEC.dart';

Future<bool> createExpense(BuildContext context) async {
  try {
    Expense e = Expense(
      expenseId: '',
      name: NewExpenseTEC.expenseNameTEC.text,
      amount: double.tryParse(NewExpenseTEC.expenseAmountTEC.text) ?? 0.0,
      date: DateTime.now(),
    );

    await context.read<ExpenseProvider>().createExpense(e);
    await context.read<ClinicProvider>().incrementDailyExpenses(e.mAmount ?? 0);

    return true;
  } on Exception catch (e) {
    debugPrint("Error creating expense: $e");
    return false;
  }
}

void deleteExpense(Expense e, BuildContext context) {
  try {
    context.read<ExpenseProvider>().deleteExpense(e);
    context.read<ClinicProvider>().incrementDailyExpenses(-(e.mAmount ?? 0));
  } on Exception catch (e) {
    debugPrint("Error deleting expense: $e");
  }
}
