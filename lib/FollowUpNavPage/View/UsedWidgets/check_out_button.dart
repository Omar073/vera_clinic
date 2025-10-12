import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';

class CheckOutButton extends StatefulWidget {
  final Client client;

  const CheckOutButton({super.key, required this.client});

  @override
  State<CheckOutButton> createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  bool _isCheckingOut = false;

  Future<void> _checkOut() async {
    bool didConfirm = false;
    await showAlertDialogue(
      context: context,
      title: 'تأكيد تسجيل الخروج',
      content: 'هل أنت متأكد من تسجيل خروج العميل ${widget.client.mName}؟',
      onPressed: () {
        didConfirm = true;
      },
    );

    if (mounted && didConfirm) {
      setState(() {
        _isCheckingOut = true;
      });
      try {
        await context.read<ClinicProvider>().checkOutClient(widget.client);
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        debugPrint('Checkout failed: $e');
        if (mounted) {
          setState(() {
            _isCheckingOut = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isCheckingOut ? null : _checkOut,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isCheckingOut ? Colors.grey : Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isCheckingOut) ...[
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 12),
            const Text('جاري تسجيل الخروج...',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ] else
            const Text('تسجيل خروج',
                style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}

