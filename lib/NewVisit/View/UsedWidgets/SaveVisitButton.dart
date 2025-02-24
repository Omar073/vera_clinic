import 'package:flutter/material.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitUF.dart';

import '../../Controller/NewVisitTEC.dart';

class SaveVisitButton extends StatefulWidget {
  const SaveVisitButton({super.key});

  @override
  State<SaveVisitButton> createState() => _ActionbuttonState();
}

class _ActionbuttonState extends State<SaveVisitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: const Text(
        "تسجيل",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        debugPrint("Button pressed: حفظ");
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
        if (success) {
          Navigator.pop(context);
        }
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
