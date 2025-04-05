import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';

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

    ExpenseProvider expenseProvider = ExpenseProvider();
    await context.read<ExpenseProvider>().createExpense(e);

    return true;
  } on Exception catch (e) {
    debugPrint("Error creating expense: $e");
    return false;
  }
}