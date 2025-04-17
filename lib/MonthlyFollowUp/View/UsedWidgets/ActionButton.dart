import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Controller/MonthlyFollowUpTEC.dart';
import '../../Controller/UtilityFunctions.dart';

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
                    await createMonthlyFollowUp(
                        widget.client, widget.cmfu, context);
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
        ElevatedButton(
          onPressed: () {
            MonthlyFollowUpTEC.clearMonthlyFollowUpTEC();
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
    );
  }
}
