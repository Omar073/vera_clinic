import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';

import '../../../Controller/ClientRegistrationUF.dart';
import '../../../Controller/NewClientCreation.dart';

class SaveButtonWidget extends StatefulWidget {
  const SaveButtonWidget({super.key});

  @override
  State<SaveButtonWidget> createState() => _SaveButtonWidgetState();
}

class _SaveButtonWidgetState extends State<SaveButtonWidget> {
  bool _isSaving = false;

  Future<void> _handleSave() async {
    // Access ClientRegistrationTEC controllers directly if they are static
    // or ensure they are accessible via context if needed.
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      // createClient likely uses ClientRegistrationTEC static controllers
      Map<bool, Client?> result = await createClient(context);
      bool success = result.keys.first;
      Client? c = result.values.last;

      if (!mounted) return;

      showMySnackBar(
          context,
          (success && c != null) ? 'تم التسجيل بنجاح' : 'فشل التسجيل',
          (success && c != null) ? Colors.green : Colors.red);

      if (success && c != null) {
        // Assuming the navigation pop is desired after saving a new client
        // If this navigates from the NewClientRegistration page, it's fine.
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isSaving ? null : _handleSave,
      icon: _isSaving
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Icon(Icons.save, color: Colors.white),
      label: Text(
        _isSaving ? 'جاري الحفظ...' : 'حفظ',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
