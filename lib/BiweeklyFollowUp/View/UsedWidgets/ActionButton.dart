import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../Controller/BiweeklyFollowUpTEC.dart';
import '../../Controller/BiweeklyFollowUpUF.dart';

class ActionButton extends StatefulWidget {
  final Client client;
  final ClientMonthlyFollowUp cmfu;
  const ActionButton({super.key, required this.client, required this.cmfu});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    if (!verifyBiweeklyRequiredFields(context) ||
                        !verifyBiweeklyFieldsDataType(context)) {
                      return;
                    }

                    bool success = await createBiweeklyFollowUp(
                        widget.client, widget.cmfu, context);

                    showMySnackBar(
                      context,
                      success
                          ? 'تم تسجيل المتابعة الشهرية بنجاح'
                          : 'فشل تسجيل المتابعة الشهرية',
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
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent)),
                  ],
                ),
              ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            BiweeklyFollowUpTEC.clear();
          },
          child: const Text('مسح', style: TextStyle(color: Colors.redAccent)),
        ),
      ],
    );
  }
}
