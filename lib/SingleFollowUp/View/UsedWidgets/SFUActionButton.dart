import 'package:flutter/material.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitUF.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../Controller/SingleFollowUpTEC.dart';
import '../../Controller/SingleFollowUpUF.dart';

class SingleFollowUpActionButton extends StatefulWidget {
  final Client client;
  const SingleFollowUpActionButton({super.key, required this.client});

  @override
  State<SingleFollowUpActionButton> createState() => _SingleFollowUpActionButtonState();
}

class _SingleFollowUpActionButtonState extends State<SingleFollowUpActionButton> {
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
              : ElevatedButton.icon(
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text('حفظ',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      if (!verifySingleFollowUpRequiredFields(context) ||
                          !verifySingleFollowUpFieldsDataType(context)) {
                        return;
                      }

                      bool success =
                          await createSingleFollowUp(widget.client, context);

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
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {
              SingleFollowUpTEC.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.clear),
            label: const Text('مسح'),
          ),
        ],
      ),
    );
  }
}
