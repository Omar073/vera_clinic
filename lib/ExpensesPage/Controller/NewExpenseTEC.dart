import 'package:flutter/cupertino.dart';

class NewExpenseTEC{
  static late TextEditingController expenseNameTEC;
  static late TextEditingController expenseAmountTEC;

  static void init() {
    expenseNameTEC = TextEditingController();
    expenseAmountTEC = TextEditingController();
  }

  static void clear() {
    expenseNameTEC.clear();
    expenseAmountTEC.clear();
  }

  static void dispose() {
    expenseNameTEC.dispose();
    expenseAmountTEC.dispose();
  }
}