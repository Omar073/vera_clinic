import 'package:flutter/material.dart';
import 'UsedWidgets/CheckInService.dart';

class CheckInButtonWidget extends StatefulWidget {
  const CheckInButtonWidget({super.key});

  @override
  State<CheckInButtonWidget> createState() => _CheckInButtonWidgetState();
}

class _CheckInButtonWidgetState extends State<CheckInButtonWidget> {
  bool _isCheckedIn = false;
  final TextEditingController _subscriptionPriceController =
      TextEditingController();
  final TextEditingController _subscriptionTypeController =
      TextEditingController();
  final TextEditingController _checkInTimeController = TextEditingController();
  bool _isAM = true;

  @override
  void dispose() {
    _subscriptionPriceController.dispose();
    _subscriptionTypeController.dispose();
    _checkInTimeController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckIn() async {
    await CheckInService.handleCheckIn(
      context: context,
      onCheckedInChanged: (isCheckedIn) {
        setState(() {
          _isCheckedIn = isCheckedIn;
        });
      },
      subscriptionPriceController: _subscriptionPriceController,
      subscriptionTypeController: _subscriptionTypeController,
      checkInTimeController: _checkInTimeController,
      isAM: _isAM,
      onAMChanged: (isAM) {
        setState(() {
          _isAM = isAM;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isCheckedIn ? null : _handleCheckIn,
      icon: _isCheckedIn
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
        _isCheckedIn ? 'جاري التسجيل...' : 'تسجيل دخول',
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