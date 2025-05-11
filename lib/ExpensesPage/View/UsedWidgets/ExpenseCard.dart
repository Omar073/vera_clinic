import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/ExpensesPage/Controller/ExpensesPageUF.dart';
import '../../../Core/Model/Classes/Expense.dart';

class ExpenseCard extends StatefulWidget {
  final Expense? expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _isDeleting 
                ? null 
                : () async {
                    setState(() {
                      _isDeleting = true;
                    });
                    await deleteExpense(widget.expense!, context);
                    setState(() {
                      _isDeleting = false;
                    });
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDeleting ? Colors.grey : Colors.red,
                disabledBackgroundColor: Colors.grey,
              ),
              icon: _isDeleting 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.delete, color: Colors.white),
              label: Text(
                _isDeleting ? 'جاري الحذف...' : 'حذف',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Wrap(
                    children: [MyTextBox(
                        title: 'اسم المصروف',
                        value: widget.expense?.mName ?? 'اسم غير متوفر'),]
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [MyTextBox(
                        title: 'المبلغ',
                        value: widget.expense?.mAmount?.toStringAsFixed(2) ??
                            'غير متوفر'),]
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [MyTextBox(
                        title: 'التاريخ',
                        value:
                            '${widget.expense?.mDate.day}/${widget.expense?.mDate.month}/${widget.expense?.mDate.year}'),]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
