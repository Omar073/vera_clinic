import 'package:flutter/material.dart';

import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../Controller/NewVisitTEC.dart';
import '../../Controller/NewVisitUF.dart';

class AddAnotherVisitButton extends StatefulWidget {
  final VoidCallback onVisitAdded;

  const AddAnotherVisitButton({super.key, required this.onVisitAdded});

  @override
  State<AddAnotherVisitButton> createState() => _AddAnotherVisitButtonState();
}

class _AddAnotherVisitButtonState extends State<AddAnotherVisitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator(color: Colors.blueAccent)
        : _buildAddVisitButton(context);
  }

  Widget _buildAddVisitButton(BuildContext context) {
    return ElevatedButton.icon(
      label: const Text(
        'إضافة زيارة أخري',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () async {
        if (!verifyVisitInput(
            context,
            NewVisitTEC.visitBMIController,
            NewVisitTEC.visitWeightController,
            NewVisitTEC.visitDateController)) {
          return;
        }
        setState(() {
          _isLoading = true;
        });

        bool success = await createVisit(context);
        if (!mounted) {
          debugPrint('Widget is not mounted');
          return;
        } // Check if the widget is still mounted

        showMySnackBar(
          context,
          success
              ? 'تم حفظ الزيارة ${NewVisitTEC.clientVisits.length} بنجاح'
              : 'فشل حفظ الزيارة',
          success ? Colors.green : Colors.red,
        );

        if (success) {
          widget.onVisitAdded();
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
    );
  }
}
