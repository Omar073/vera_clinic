import 'package:flutter/material.dart';
import 'package:vera_clinic/UpdateMonthlyFollowUpDetailsPage/Controller/UpdateMonthlyFollowUpDetailsTEC.dart';

import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Core/View/PopUps/MySnackBar.dart';
import '../Controller/UpdateMonthlyFollowUpDetailsUF.dart';

class UpdateMonthlyFollowUpButton extends StatefulWidget {
  final ClientMonthlyFollowUp cmfu;
  final VoidCallback onMonthlyFollowUpUpdated;

  const UpdateMonthlyFollowUpButton({
    super.key,
    required this.cmfu,
    required this.onMonthlyFollowUpUpdated,
  });

  @override
  State<UpdateMonthlyFollowUpButton> createState() => _UpdateMonthlyFollowUpButtonState();
}

class _UpdateMonthlyFollowUpButtonState extends State<UpdateMonthlyFollowUpButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator(color: Colors.blueAccent)
        : _buildUpdateMonthlyFollowUpButton(context, widget.cmfu);
  }

  Widget _buildUpdateMonthlyFollowUpButton(BuildContext context, ClientMonthlyFollowUp cmfu) {
    return ElevatedButton.icon(
      label: const Text(
        "تعديل",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        if (!verifyMonthlyFollowUpInput(
            context,
            UpdateMonthlyFollowUpDetailsTEC.dateController)) {
          return;
        }

        setState(() {
          _isLoading = true;
        });

        bool success = await updateMonthlyFollowUp(context, cmfu);
        showMySnackBar(
            context,
            success ? 'تم تعديل المتابعة بنجاح' : 'فشل تعديل المتابعة',
            success ? Colors.green : Colors.red);

        if (success) {
          widget.onMonthlyFollowUpUpdated();
          Navigator.pop(context);
        }

        setState(() {
          _isLoading = false;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        textStyle: const TextStyle(fontSize: 20),
      ),
      icon: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }
}
