import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';

import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Core/View/PopUps/MySnackBar.dart';
import 'UpdateMonthlyFollowUpDetailsTEC.dart';

import '../../Core/Services/DebugLoggerService.dart';
final DateFormat _cmfuDateFormat = DateFormat('dd/MM/yyyy');

DateTime? _parseFollowUpDate(String rawInput) {
  final input = rawInput.trim();
  if (input.isEmpty) return null;
  try {
    return _cmfuDateFormat.parseStrict(input);
  } catch (_) {
    try {
      return DateTime.parse(input);
    } catch (_) {
      return null;
    }
  }
}

Future<bool> updateMonthlyFollowUp(BuildContext context, ClientMonthlyFollowUp cmfu) async {
  try {
    final parsedDate =
        _parseFollowUpDate(UpdateMonthlyFollowUpDetailsTEC.dateController.text);
    cmfu.mDate = parsedDate ?? DateTime.now();
    
    // Update all fields
    cmfu.mWater = UpdateMonthlyFollowUpDetailsTEC.waterController.text;
    cmfu.mBMI = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.bmiController.text) ?? 0.0;
    cmfu.mMuscleMass = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.muscleMassController.text) ?? 0.0;
    cmfu.mPBF = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.pbfController.text) ?? 0.0;
    cmfu.mBMR = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.bmrController.text) ?? 0.0;
    cmfu.mMaxWeight = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.maxWeightController.text) ?? 0.0;
    cmfu.mOptimalWeight = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.optimalWeightController.text) ?? 0.0;
    cmfu.mDailyCalories = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.dailyCaloriesController.text) ?? 0.0;
    cmfu.mMaxCalories = double.tryParse(UpdateMonthlyFollowUpDetailsTEC.maxCaloriesController.text) ?? 0.0;
    cmfu.mNotes = UpdateMonthlyFollowUpDetailsTEC.notesController.text;

    await context.read<ClientMonthlyFollowUpProvider>().updateClientMonthlyFollowUp(cmfu);

    return true;
  } on Exception catch (e) {
    mDebug("Error updating monthly follow up: $e");
    return false;
  }
}

bool verifyMonthlyFollowUpInput(BuildContext context, TextEditingController dateController) {
  if (dateController.text.isEmpty) {
    showMySnackBar(context, 'يرجى إدخال تاريخ المتابعة', Colors.red);
    return false;
  }

  DateTime? parsedDate = _parseFollowUpDate(dateController.text);
  if (parsedDate == null) {
    showMySnackBar(context, 'يرجى إدخال تاريخ صحيح', Colors.red);
    return false;
  }

  return true;
}
