import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/InvalidDataTypeSnackBar.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/SubscriptionTypeDropdown.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import '../../../Controller/ClientRegistrationTEC.dart';
import '../../../Controller/ClientRegistrationUF.dart';
import '../../../Controller/NewClientCreation.dart';

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

  @override
  void dispose() {
    _subscriptionPriceController.dispose();
    _subscriptionTypeController.dispose();
    _checkInTimeController.dispose();
    super.dispose();
  }

  Future<void> _processClientSubscription(
      Client client, double subscriptionPrice, String checkInTime) async {
    client.mSubscriptionType =
        getSubscriptionTypeFromString(_subscriptionTypeController.text);
    await _checkInClientAndUpdateData(client, subscriptionPrice, checkInTime);
  }

  Future<void> _checkInClientAndUpdateData(
      Client client, double subscriptionPrice, String checkInTime) async {
    // Create ISO timestamp with today's date and provided time
    final now = DateTime.now();
    final timeParts = checkInTime.split(':');
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
        .checkInClient(client, checkInTimeISO);
    await context.read<ClinicProvider>().incrementDailyPatients();
    await context.read<ClinicProvider>().updateDailyIncome(subscriptionPrice);
    await context.read<ClientProvider>().updateClient(client);

    if (!mounted) return;
    showMySnackBar(context, 'تم تسجيل العميل بنجاح', Colors.green);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Widget _buildSubscriptionDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        MyInputField(
            myController: _subscriptionPriceController,
            hint: 'أدخل سعر الاشتراك',
            label: 'سعر الاشتراك'),
        const SizedBox(height: 16),
        SubscriptionTypeDropdown(
            subscriptionTypeController: _subscriptionTypeController),
        const SizedBox(height: 16),
        MyInputField(
          myController: _checkInTimeController,
          hint: "HH:MM",
          label: "وقت تسجيل الدخول",
        ),
      ],
    );
  }

  Future<Map<String, dynamic>?> _showSubscriptionDialog() async {
    // Set default time to current time
    final now = DateTime.now();
    _checkInTimeController.text = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    return await showDialog<Map<String, dynamic>?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        // Renamed context to avoid conflict
        return AlertDialog(
          backgroundColor: Colors.blue[50]!,
          title: const Text(
            'إدخال بيانات الاشتراك',
            textAlign: TextAlign.end,
          ),
          content: _buildSubscriptionDialogContent(),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Validate time input
                  final timeText = _checkInTimeController.text.trim();
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

                  final double? subscriptionPrice =
                      double.tryParse(_subscriptionPriceController.text);

                  if (subscriptionPrice == null) {
                    showInvalidDataTypeSnackBar(context, 'سعر الاشتراك');
                    return;
                  }
                  
                  Navigator.of(dialogContext).pop({
                    'subscriptionPrice': subscriptionPrice,
                    'checkInTime': timeText,
                  });
                } catch (e) {
                  showInvalidDataTypeSnackBar(context, 'سعر الاشتراك');
                }
              },
              child: const Text(
                'تأكيد',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(null), // Use dialogContext
              child: const Text(
                'إلغاء',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleCheckIn() async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    if (await context
        .read<ClientProvider>()
        .isPhoneNumUsed(ClientRegistrationTEC.phoneController.text)) {
      if (!mounted) return;
      showMySnackBar(context, 'هذا الرقم مستخدم بالفعل', Colors.red);
      return;
    }

    final Map<String, dynamic>? dialogResult = await _showSubscriptionDialog();

    if (dialogResult == null) {
      return;
    }

    final double subscriptionPrice = dialogResult['subscriptionPrice'];
    final String checkInTime = dialogResult['checkInTime'];

    setState(() => _isCheckedIn = true);
    try {
      final Map<bool, Client?> result = await createClient(context);
      final bool success = result.keys.first;
      final Client? client = result.values.last;

      if (!mounted) return;

      if (success && client != null) {
        await _processClientSubscription(client, subscriptionPrice, checkInTime);
      } else {
        showMySnackBar(
            context, "فشل في تسجيل العميل. حاول مرة أخرى.", Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() => _isCheckedIn = false);
      }
    }
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
