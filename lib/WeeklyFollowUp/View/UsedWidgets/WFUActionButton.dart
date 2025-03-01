import 'package:flutter/material.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/UtilityFunctions.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../Controller/VisitTEC.dart';

class VisitActionButton extends StatefulWidget {
  final Client client;
  const VisitActionButton({super.key, required this.client});

  @override
  State<VisitActionButton> createState() => _VisitActionButtonState();
}

class _VisitActionButtonState extends State<VisitActionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            bool success = await createWeeklyFollowUp(widget.client, context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                      success ? 'تم تسجيل العميل بنجاح' : 'فشل تسجيل العميل'),
                ),
                backgroundColor: success ? Colors.green : Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
            if (success) {
              Navigator.pop(context);
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.blueAccent),
              SizedBox(width: 12),
              Text('حفظ',
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
            ],
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            WeeklyFollowUpTEC.clear();
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.redAccent),
              SizedBox(width: 12),
              Text('مسح',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent)),
            ],
          ),
        ),
      ],
    );
  }
}
