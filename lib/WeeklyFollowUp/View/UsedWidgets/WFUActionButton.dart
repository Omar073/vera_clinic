import 'package:flutter/material.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitUF.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/WeeklyFollowUpUF.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../Controller/WeeklyFollowUpTEC.dart';

class VisitActionButton extends StatefulWidget {
  final Client client;
  const VisitActionButton({super.key, required this.client});

  @override
  State<VisitActionButton> createState() => _VisitActionButtonState();
}

class _VisitActionButtonState extends State<VisitActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? const CircularProgressIndicator(color: Colors.blueAccent)
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      if (!verifyVisitInput(
                          context,
                          WeeklyFollowUpTEC.visitBMIController,
                          WeeklyFollowUpTEC.visitWeightController,
                          TextEditingController(text: ' '))) {
                        return;
                      }

                      bool success =
                          await createWeeklyFollowUp(widget.client, context);

                      showMySnackBar(
                        context,
                        success ? 'تم تسجيل الزيارة بنجاح' : 'فشل تسجيل الزيارة',
                        success ? Colors.green : Colors.red,
                      );
                      if (success) {
                        Navigator.pop(context);
                      }
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.blueAccent),
                      SizedBox(width: 12),
                      Text('حفظ',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueAccent)),
                    ],
                  ),
                ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              WeeklyFollowUpTEC.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
            ),
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
      ),
    );
  }
}
