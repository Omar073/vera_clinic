import 'package:flutter/material.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitUF.dart';

import '../../../Core/View/SnackBars/MySnackBar.dart';
import '../../Controller/NewVisitTEC.dart';

class SaveVisitButton extends StatefulWidget {
  const SaveVisitButton({super.key});

  @override
  State<SaveVisitButton> createState() => _SaveVisitButtonState();
}

class _SaveVisitButtonState extends State<SaveVisitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton.icon(
            label: const Text(
              "تسجيل",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              if (!verifyVisitInput(context)) return;

              setState(() {
                _isLoading = true;
              });

              debugPrint("Button pressed: حفظ");
              bool success = await createVisit();
              MySnackBar(
                  message: success
                      ? 'تم حفظ الزيارة ${NewVisitTEC.clientVisits.length + 1} بنجاح'
                      : 'فشل حفظ الزيارة',
                  color: success ? Colors.green : Colors.red);

              if (success) {
                Navigator.pop(context);
              }

              setState(() {
                _isLoading = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 27, 169, 34),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          );
  }
}
