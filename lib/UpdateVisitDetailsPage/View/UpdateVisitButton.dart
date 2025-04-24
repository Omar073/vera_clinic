import 'package:flutter/material.dart';
import 'package:vera_clinic/UpdateVisitDetailsPage/Controller/UpdateVisitDetailsTEC.dart';

import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/SnackBars/MySnackBar.dart';
import '../../NewVisit/Controller/NewVisitUF.dart';
import '../Controller/UpdateVisitDetailsUF.dart';

class UpdateVisitButton extends StatefulWidget {
  final Visit v;
  final VoidCallback onVisitUpdated;

  const UpdateVisitButton({
    super.key,
    required this.v,
    required this.onVisitUpdated,
  });

  @override
  State<UpdateVisitButton> createState() => _UpdateVisitButtonState();
}

class _UpdateVisitButtonState extends State<UpdateVisitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator(color: Colors.blueAccent)
        : _buildUpdateVisitButton(context, widget.v);
  }

  Widget _buildUpdateVisitButton(BuildContext context, Visit v) {
    return ElevatedButton.icon(
      label: const Text(
        "تعديل",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        if (!verifyVisitInput(
            context,
            UpdateVisitDetailsTEC.visitBMIController,
            UpdateVisitDetailsTEC.visitWeightController,
            UpdateVisitDetailsTEC.visitDateController)) {
          return;
        }

        setState(() {
          _isLoading = true;
        });

        bool success = await updateVisit(context, v);
        showMySnackBar(
            context,
            success ? 'تم تعديل الزيارة بنجاح' : 'فشل تعديل الزيارة',
            success ? Colors.green : Colors.red);

        if (success) {
          widget.onVisitUpdated();
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
