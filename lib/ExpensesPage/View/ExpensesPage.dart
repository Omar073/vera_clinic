import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/ExpensesPage/Controller/NewExpenseTEC.dart';
import 'package:vera_clinic/ExpensesPage/Controller/NewExpenseUF.dart';

import '../../Core/Model/Classes/Expense.dart';
import '../../Core/View/SnackBars/MySnackBar.dart';
import 'UsedWidgets/ExpensesList.dart';

class ExpensesPage extends StatefulWidget {
  List<Expense?> expenses;
  ExpensesPage({super.key, required this.expenses});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    NewExpenseTEC.init();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Page'),
        centerTitle: true,
        backgroundColor: Colors.blue[50]!,
      ),
      body: Background(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        bool success = await createExpense(context);

                        showMySnackBar(
                            context,
                            success
                                ? 'تم حفظ المصروف بنجاح'
                                : 'فشل حفظ المصروف',
                            success ? Colors.green : Colors.red);

                        if (success) {
                          setState(() {
                            NewExpenseTEC.expenseNameTEC.clear();
                            NewExpenseTEC.expenseAmountTEC.clear();

                          });
                        }
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(width: 25),
                  MyInputField(
                    myController: NewExpenseTEC.expenseAmountTEC,
                    hint: '',
                    label: 'المبلغ',
                  ),
                  const SizedBox(width: 25),
                  MyInputField(
                    myController: NewExpenseTEC.expenseNameTEC,
                    hint: '',
                    label: 'اسم المصروف',
                  ),

                  //todo: should we add today as default date?
                ],
              ),
            ),
            const SizedBox(height: 16),
            widget.expenses.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد مصروفات',
                      style: TextStyle(fontSize: 18),
                      textDirection: TextDirection.rtl,
                    ),
                  )
                : const Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ExpensesList(),
                    ),
                ),
          ],
        ),
      )),
    );
  }
}
