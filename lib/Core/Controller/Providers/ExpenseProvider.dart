import 'package:flutter/cupertino.dart';

import '../../Model/Classes/Expense.dart';
import '../../Model/Firebase/ExpenseFirestoreMethods.dart';

class ExpenseProvider with ChangeNotifier {
  final ExpenseFirestoreMethods _mExpenseFirestoreMethods =
      ExpenseFirestoreMethods();

  List<Expense?> _mCachedExpenses = [];

  List<Expense?> get cachedExpenses => _mCachedExpenses;
  ExpenseFirestoreMethods get expenseFirestoreMethods =>
      _mExpenseFirestoreMethods;

  Future<void> createExpense(Expense expense) async {
    expense.mExpenseId = await expenseFirestoreMethods.createExpense(expense);
    cachedExpenses.add(expense);
    notifyListeners();
  }

  Future<Expense?> getExpenseById(String expenseId) async {
    // Check cached expenses first
    Expense? expense = cachedExpenses.firstWhere(
      (expense) => expense?.mExpenseId == expenseId,
      orElse: () => null,
    );

    expense ??= await expenseFirestoreMethods.fetchExpenseById(expenseId);
    expense == null ? cachedExpenses.add(expense) : null;
    notifyListeners();
    return expense;
  }

  Future<List<Expense?>> getAllExpenses() async {
    List<Expense?> expenses = await expenseFirestoreMethods.fetchAllExpenses();
    _mCachedExpenses = expenses;

    notifyListeners();
    return expenses;
  }

  Future<void> monthlyClearExpenses() async {
    _mCachedExpenses.clear();
    await expenseFirestoreMethods.clearAllExpenses();
    notifyListeners();
  }
}
