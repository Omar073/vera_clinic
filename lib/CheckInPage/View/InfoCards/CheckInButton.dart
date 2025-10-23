import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';

import '../../../Core/Controller/UtilityFunctions.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';

class CheckInButton extends StatefulWidget {
  final TextEditingController visitSubscriptionTypeController;
  final TextEditingController visitSubscriptionPriceController;
  final TextEditingController checkInTimeController;
  final Client? client;

  const CheckInButton({
    super.key,
    required this.client,
    required this.visitSubscriptionTypeController,
    required this.visitSubscriptionPriceController,
    required this.checkInTimeController,
  });

  @override
  State<CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends State<CheckInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const Background(
              child: Center(
                  child: CircularProgressIndicator(
              color: Colors.blueAccent,
            )))
          : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  // Validate time input
                  final timeText = widget.checkInTimeController.text.trim();
                  if (timeText.isEmpty) {
                    showMySnackBar(context, 'يرجى إدخال وقت تسجيل الدخول', Colors.red);
                    return;
                  }

                  // Parse and validate time format (HH:MM)
                  final timeRegex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                  if (!timeRegex.hasMatch(timeText)) {
                    showMySnackBar(context, 'تنسيق الوقت غير صحيح. استخدم HH:MM', Colors.red);
                    return;
                  }

                  final double? subscriptionPrice = double.tryParse(
                      widget.visitSubscriptionPriceController.text);

                  if (subscriptionPrice == null) {
                    showMySnackBar(context, 'الرجاء إدخال سعر اشتراك صحيح', Colors.red);
                    return;
                  }

                  widget.client?.mSubscriptionType =
                      getSubscriptionTypeFromString(
                          widget.visitSubscriptionTypeController.text);

                  bool isAlreadyCheckedIn = await context
                      .read<ClinicProvider>()
                      .isClientCheckedIn(widget.client!.mClientId);
                  if (isAlreadyCheckedIn) {
                    showMySnackBar(context, 'العميل مسجل بالفعل', Colors.red);
                    return;
                  }

                  // Create ISO timestamp with today's date and provided time
                  final now = DateTime.now();
                  final timeParts = timeText.split(':');
                  final checkInDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    int.parse(timeParts[0]),
                    int.parse(timeParts[1]),
                  );
                  final checkInTimeISO = checkInDateTime.toIso8601String();

                  await context
                      .read<ClinicProvider>()
                      .checkInClient(widget.client!, checkInTimeISO);
                  await context
                      .read<ClinicProvider>()
                      .incrementDailyPatients();
                  await context
                      .read<ClinicProvider>()
                      .updateDailyIncome(subscriptionPrice);
                  await context
                      .read<ClientProvider>()
                      .updateClient(widget.client!);

                  showMySnackBar(
                      context, 'تم تسجيل العميل بنجاح', Colors.green);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } catch (e) {
                  if (mounted) {
                    showMySnackBar(
                        context, 'فشل تسجيل الدخول: ${e.toString()}', Colors.red);
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Set background color to white
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: Colors.blueAccent),
                  SizedBox(width: 12),
                  Text('تسجيل دخول',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                ],
              ),
            ),
    );
  }
}
