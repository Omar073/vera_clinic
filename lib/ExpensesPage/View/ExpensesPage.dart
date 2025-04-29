import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/ExpensesPage/Controller/NewExpenseTEC.dart';
import 'package:vera_clinic/ExpensesPage/Controller/ExpensesPageUF.dart';

import '../../Core/Controller/Providers/ExpenseProvider.dart';
import '../../Core/Model/Classes/Expense.dart';
import '../../Core/View/PopUps/MySnackBar.dart';
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
    widget.expenses = context.watch<ExpenseProvider>().cachedExpenses;
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة المصروفات'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await context.read<ExpenseProvider>().getAllExpenses();
            },
          ),
        ],
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

                  //todo: should we keep adding today as default date?
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
