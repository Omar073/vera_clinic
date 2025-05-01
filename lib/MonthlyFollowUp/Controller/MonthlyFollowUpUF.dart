import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/PopUps/RequiredFieldSnackBar.dart';

import '../../Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import 'MonthlyFollowUpTEC.dart';

Future<bool> createMonthlyFollowUp(
    Client c, ClientMonthlyFollowUp cmfu, BuildContext context) async {
  try {
    // Helper function to parse text or fallback to the existing value
    double? parseOrFallback(String text, double? fallback) {
      return text.isEmpty ? fallback : double.tryParse(text) ?? fallback;
    }

    // Create the ClientMonthlyFollowUp object
    ClientMonthlyFollowUp clientMonthlyFollowUp = ClientMonthlyFollowUp(
      clientMonthlyFollowUpId: '',
      clientId: c.mClientId,
      bmi: parseOrFallback(MonthlyFollowUpTEC.mBMIController.text, cmfu.mBMI),
      pbf: parseOrFallback(MonthlyFollowUpTEC.mPBFController.text, cmfu.mPBF),
      water:
          parseOrFallback(MonthlyFollowUpTEC.mWaterController.text, cmfu.mWater),
      maxWeight: parseOrFallback(
          MonthlyFollowUpTEC.mMaxWeightController.text, cmfu.mMaxWeight),
      optimalWeight: parseOrFallback(
          MonthlyFollowUpTEC.mOptimalWeightController.text, cmfu.mOptimalWeight),
      bmr: parseOrFallback(MonthlyFollowUpTEC.mBMRController.text, cmfu.mBMR),
      maxCalories: parseOrFallback(
          MonthlyFollowUpTEC.mMaxCaloriesController.text, cmfu.mMaxCalories),
      dailyCalories: parseOrFallback(
          MonthlyFollowUpTEC.mDailyCaloriesController.text, cmfu.mDailyCalories),
    );

    // Save the ClientMonthlyFollowUp object
    await context
        .read<ClientMonthlyFollowUpProvider>()
        .createClientMonthlyFollowUp(clientMonthlyFollowUp);

    // Print the created object for debugging
    // clientMonthlyFollowUp.printClientMonthlyFollowUp();
    return true;
  } on Exception catch (e) {
    debugPrint('Error creating monthly follow up: $e');
    return false;
  }
}

bool verifyMonthlyFolowUpInput(
    BuildContext context,
    TextEditingController mBMIController,
    TextEditingController mWeightController) {
  if (mBMIController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'مؤشر كتلة الجسم');
    return false;
  }
  if (mWeightController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'نسبة الدهون');
    return false;
  }
  return true;
}