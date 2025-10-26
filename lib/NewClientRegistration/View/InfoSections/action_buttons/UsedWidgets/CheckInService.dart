import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/ClientRegistrationTEC.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/ClientRegistrationUF.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/NewClientCreation.dart';
import 'SubscriptionDialogService.dart';

class CheckInService {
  static Future<void> processClientSubscription({
    required BuildContext context,
    required Client client,
    required double subscriptionPrice,
    required String checkInTime,
    required bool isAM,
  }) async {
    await _checkInClientAndUpdateData(
      context: context,
      client: client,
      subscriptionPrice: subscriptionPrice,
      checkInTime: checkInTime,
      isAM: isAM,
    );
  }

  static Future<void> _checkInClientAndUpdateData({
    required BuildContext context,
    required Client client,
    required double subscriptionPrice,
    required String checkInTime,
    required bool isAM,
  }) async {
    // Create ISO timestamp with today's date and provided time (convert 12-hour to 24-hour)
    final timeParts = checkInTime.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final checkInDateTime = convert12To24Hour(hour, minute, isAM);
    final checkInTimeISO = checkInDateTime.toIso8601String();

    await context.read<ClinicProvider>().checkInClient(client, checkInTimeISO);
    await context.read<ClinicProvider>().incrementDailyPatients();
    await context.read<ClinicProvider>().updateDailyIncome(subscriptionPrice);
    await context.read<ClientProvider>().updateClient(client);

    if (!context.mounted) return;
    showMySnackBar(context, 'تم تسجيل العميل بنجاح', Colors.green);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  static Future<void> handleCheckIn({
    required BuildContext context,
    required Function(bool) onCheckedInChanged,
    required TextEditingController subscriptionPriceController,
    required TextEditingController subscriptionTypeController,
    required TextEditingController checkInTimeController,
    required bool isAM,
    required Function(bool) onAMChanged,
  }) async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    if (await context
        .read<ClientProvider>()
        .isPhoneNumUsed(ClientRegistrationTEC.phoneController.text)) {
      if (!context.mounted) return;
      showMySnackBar(context, 'هذا الرقم مستخدم بالفعل', Colors.red);
      return;
    }

    // Import the SubscriptionDialogService
    final Map<String, dynamic>? dialogResult = await SubscriptionDialogService.showSubscriptionDialog(
      context: context,
      subscriptionPriceController: subscriptionPriceController,
      subscriptionTypeController: subscriptionTypeController,
      checkInTimeController: checkInTimeController,
      isAM: isAM,
      onAMChanged: onAMChanged,
    );

    if (dialogResult == null) {
      return;
    }

    final double subscriptionPrice = dialogResult['subscriptionPrice'];
    final String checkInTime = dialogResult['checkInTime'];
    final bool dialogIsAM = dialogResult['isAM'] ?? isAM;

    onCheckedInChanged(true);
    try {
      final Map<bool, Client?> result = await createClient(context);
      final bool success = result.keys.first;
      final Client? client = result.values.last;

      if (!context.mounted) return;

      if (success && client != null) {
        client.mSubscriptionType =
            getSubscriptionTypeFromString(subscriptionTypeController.text);
        await processClientSubscription(
          context: context,
          client: client,
          subscriptionPrice: subscriptionPrice,
          checkInTime: checkInTime,
          isAM: dialogIsAM,
        );
      } else {
        showMySnackBar(
            context, "فشل في تسجيل العميل. حاول مرة أخرى.", Colors.red);
      }
    } finally {
      if (context.mounted) {
        onCheckedInChanged(false);
      }
    }
  }
}
