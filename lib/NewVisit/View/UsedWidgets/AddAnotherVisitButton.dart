import 'package:flutter/material.dart';

import '../../Controller/NewVisitTEC.dart';
import '../../Controller/NewVisitUF.dart';

class AddAnotherVisitButton extends StatefulWidget {
  const AddAnotherVisitButton({super.key});

  @override
  State<AddAnotherVisitButton> createState() => _AddAnotherVisitButtonState();
}

class _AddAnotherVisitButtonState extends State<AddAnotherVisitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton.icon(
            label: const Text(
              'إضافة زيارة أخري',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              if (!verifyVisitInput(context)) return;

              setState(() {
                _isLoading = true;
              });

              bool success = await createVisit();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(success
                        ? 'تم حفظ الزيارة ${NewVisitTEC.clientVisits.length + 1} بنجاح'
                        : 'فشل حفظ الزيارة'),
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: success ? Colors.green : Colors.red,
                ),
              );

              setState(() {
                _isLoading = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          );
  }
}
