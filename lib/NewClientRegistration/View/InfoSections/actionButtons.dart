import 'package:flutter/material.dart';

import '../../../NewVisit/View/NewVisit.dart';
import '../../Controller/UtilityFunctions.dart';

class actionButtons extends StatefulWidget {
  const actionButtons({super.key});

  @override
  State<actionButtons> createState() => _actionButtonsState();
}

class _actionButtonsState extends State<actionButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              debugPrint("Button pressed: حفظ");
              bool success = await createClient();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success
                      ? 'Client registration successful'
                      : 'Client registration failed'),
                  backgroundColor: success ? Colors.green : Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
              if (success) disposeControllers();
            },
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text(
              "حفظ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewVisit()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "تسجيل زيارة سابقة",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              clearControllers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Controllers cleared'),
                  backgroundColor: Colors.blueAccent,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.clear, color: Colors.white),
            label: const Text(
              "مسح",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
