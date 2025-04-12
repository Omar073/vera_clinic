import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Expense{
  String mExpenseId;
  String? mName;
  double? mAmount;
  DateTime mDate;

  Expense({
    required String expenseId,
    required String name,
    required double amount,
    required DateTime date,
  })  : mExpenseId = expenseId,
        mName = name,
        mAmount = amount,
        mDate = date;
  
  void printExpense() {
    debugPrint('\n\t\t<<Expense>>\n'
        'id: $mExpenseId, name: $mName, amount: $mAmount, date: $mDate');
  }

  factory Expense.fromFirestore(Map<String, dynamic> data) {
    return Expense(
      expenseId: data['expenseId'] as String,
      name: data['name'] as String,
      amount: (data['amount'] as num).toDouble(),
      date: (data['date'] as Timestamp?)
          !.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseId': mExpenseId,
      'name': mName,
      'amount': mAmount,
      'date': mDate,
    };
  }
}
