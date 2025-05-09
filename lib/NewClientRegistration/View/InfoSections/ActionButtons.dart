import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../../NewVisit/View/NewVisit.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../../Controller/ClientRegistrationUF.dart';
import '../../Controller/NewClientCreation.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({super.key});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isSaving = false;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _saveButton(),
          const SizedBox(width: 16),
          _loginButton(),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewVisit()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "تسجيل زيارة سابقة",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              ClientRegistrationTEC.clear();
              showMySnackBar(context, 'تم مسح البيانات', Colors.blueAccent);
            },
            icon: const Icon(Icons.clear, color: Colors.white),
            label: const Text(
              "مسح",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    //todo: separate into different files
    return _buildButton(
      isLoading: isSaving,
      onPressed: () async {
        await _handleSave();
      },
      icon: Icons.save,
      loadingText: 'جاري الحفظ...',
      text: 'حفظ',
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _loginButton() {
    return _buildButton(
      isLoading: isLoggingIn,
      onPressed: () async {
        await _handleLogin();
      },
      icon: Icons.person_add,
      loadingText: 'جاري التسجيل...',
      text: 'تسجيل دخول',
      backgroundColor: Colors.teal,
    );
  }

  Widget _buildButton({
    required bool isLoading,
    required VoidCallback onPressed,
    required IconData icon,
    required String loadingText,
    required String text,
    required Color backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Icon(icon, color: Colors.white),
      label: Text(
        isLoading ? loadingText : text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    setState(() => isSaving = true);
    try {
      Map<bool, Client?> result = await createClient(context);
      bool success = result.keys.first;
      Client? c = result.values.last;

      if (!mounted) return; // Check if the widget is still mounted

      showMySnackBar(
          context,
          (success && c != null) ? 'تم التسجيل بنجاح' : 'فشل التسجيل',
          (success && c != null) ? Colors.green : Colors.red);

      if (success) {
        Navigator.pop(context);
      }
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> _handleLogin() async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    setState(() => isLoggingIn = true);
    try {
      final Map<bool, Client?> result = await createClient(context);
      final bool success = result.keys.first;
      final Client? c = result.values.last;

      if (!mounted) return;

      if (success && c != null) {
        final checkedIn = await checkInNewClient(context, c);
        if (checkedIn) {
          showMySnackBar(context, "تم تسجيل الدخول بنجاح", Colors.green);
          Navigator.pop(context);
        } else {
          showMySnackBar(context, "حدث خطأ أثناء تسجيل الدخول. حاول مرة أخرى.",
              Colors.red);
        }
      } else {
        showMySnackBar(
            context, "فشل في تسجيل العميل. حاول مرة أخرى.", Colors.red);
      }
    } finally {
      setState(() => isLoggingIn = false);
    }
  }
}
