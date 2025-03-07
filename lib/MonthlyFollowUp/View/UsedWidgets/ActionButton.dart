import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../Controller/MonthlyFollowUpTEC.dart';
import '../../Controller/UtilityFunctions.dart';

class ActionButton extends StatefulWidget {
  final Client client;
  const ActionButton({super.key, required this.client});

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
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await createMonthlyFollowUp(widget.client, context);
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
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
