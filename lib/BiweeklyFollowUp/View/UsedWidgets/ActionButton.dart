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
            : ElevatedButton.icon(
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text('حفظ',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
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
                          ? 'تم تسجيل المتابعة بنجاح'
                          : 'فشل تسجيل المتابعة',
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
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            BiweeklyFollowUpTEC.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.clear),
          label: const Text('مسح'),
        ),
      ],
    );
  }
}
