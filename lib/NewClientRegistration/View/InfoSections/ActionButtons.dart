import 'package:flutter/material.dart';

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('تم مسح البيانات')),
                  backgroundColor: Colors.blueAccent,
                  duration: Duration(seconds: 2),
                ),
              );
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
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    //todo: reduce complexity
    return ElevatedButton.icon(
      onPressed: isSaving
          ? null
          : () async {
              debugPrint("Button pressed: حفظ");
              if (!verifyInput(context)) return;

              setState(() => isSaving = true);
              try {
                bool success = await createClient(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(success
                          ? 'تم تسجيل العميل بنجاح'
                          : 'فشل تسجيل العميل'),
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
                if (success) {
                  ClientRegistrationTEC.dispose();
                  Navigator.pop(context);
                }
              } finally {
                setState(() => isSaving = false);
              }
            },
      icon: isSaving
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
        isSaving ? 'جاري الحفظ...' : 'حفظ',
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

  Widget _loginButton() {
    //todo: reduce complexity
    return ElevatedButton.icon(
      onPressed: isLoggingIn
          ? null
          : () async {
              debugPrint("Button pressed: تسجيل دخول");
              if (!verifyInput(context)) return;

              setState(() => isLoggingIn = true);
              try {
                bool success = await createClient(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                        child:
                            Text(success ? 'تم التسجيل بنجاح' : 'فشل التسجيل')),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
                if (success) {
                  checkInNewClient(context);
                  ClientRegistrationTEC.dispose();
                  Navigator.pop(context);
                }
              } finally {
                setState(() => isLoggingIn = false);
              }
            },
      icon: isLoggingIn
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Icon(Icons.person_add, color: Colors.white),
      label: Text(
        isLoggingIn ? 'جاري التسجيل...' : 'تسجيل دخول',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
