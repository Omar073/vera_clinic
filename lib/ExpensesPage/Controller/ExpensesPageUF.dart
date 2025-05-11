import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';

import '../../Core/Controller/Providers/ClinicProvider.dart';
import '../../Core/Model/Classes/Expense.dart';
import '../../Core/View/PopUps/MySnackBar.dart';
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
    await context.read<ClinicProvider>().updateDailyExpenses(e.mAmount ?? 0);

    showMySnackBar(context, 'تم إضافة المصروف بنجاح', Colors.green);
    return true;
  } on Exception catch (e) {
    debugPrint("Error creating expense: $e");
    showMySnackBar(context, 'فشل إضافة المصروف', Colors.red);
    return false;
  }
}

Future<void> deleteExpense(Expense e, BuildContext context) async {
  try {
    await context.read<ExpenseProvider>().deleteExpense(e);

    if (e.mDate.year == DateTime.now().year &&
        e.mDate.month == DateTime.now().month &&
        e.mDate.day == DateTime.now().day) {
      context.read<ClinicProvider>().updateDailyExpenses(-(e.mAmount ?? 0));
    } else {
      context.read<ClinicProvider>().updateMonthlyExpenses(-(e.mAmount ?? 0));
    }
    showMySnackBar(context, 'تم حذف المصروف بنجاح', Colors.green);
  } on Exception catch (e) {
    debugPrint("Error deleting expense: $e");
    showMySnackBar(context, 'فشل حذف المصروف', Colors.red);
  }
}
