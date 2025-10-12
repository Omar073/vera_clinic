import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/PopUps/RequiredFieldSnackBar.dart';

import '../../Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/PopUps/InvalidDataTypeSnackBar.dart';
import 'BiweeklyFollowUpTEC.dart';
import '../../Core/Controller/Providers/ClientProvider.dart';

Future<bool> createBiweeklyFollowUp(
    Client c, ClientMonthlyFollowUp cmfu, BuildContext context) async {
  try {
    // Helper function to parse text or fallback to the existing value
    double? parseOrFallback(String text, double? fallback) {
      return text.isEmpty ? fallback : double.tryParse(text) ?? fallback;
    }

    final newWeight =
        double.tryParse(BiweeklyFollowUpTEC.mWeightController.text) ?? c.mWeight;

    double bmi = cmfu.mBMI ?? 0.0;
    if (c.mHeight != null && c.mHeight! > 0 && newWeight != null) {
      bmi = newWeight / ((c.mHeight! / 100) * (c.mHeight! / 100));
    }

    // Create the ClientMonthlyFollowUp object
    ClientMonthlyFollowUp clientMonthlyFollowUp = ClientMonthlyFollowUp(
      clientMonthlyFollowUpId: '',
      clientId: c.mClientId,
      bmi: bmi,
      pbf: parseOrFallback(BiweeklyFollowUpTEC.mPBFController.text, cmfu.mPBF),
      water: BiweeklyFollowUpTEC.mWaterController.text.isEmpty
          ? cmfu.mWater
          : BiweeklyFollowUpTEC.mWaterController.text,
      maxWeight: parseOrFallback(
          BiweeklyFollowUpTEC.mMaxWeightController.text, cmfu.mMaxWeight),
      optimalWeight: parseOrFallback(
          BiweeklyFollowUpTEC.mOptimalWeightController.text, cmfu.mOptimalWeight),
      bmr: parseOrFallback(BiweeklyFollowUpTEC.mBMRController.text, cmfu.mBMR),
      maxCalories: parseOrFallback(
          BiweeklyFollowUpTEC.mMaxCaloriesController.text, cmfu.mMaxCalories),
      dailyCalories: parseOrFallback(
          BiweeklyFollowUpTEC.mDailyCaloriesController.text, cmfu.mDailyCalories),
      muscleMass: parseOrFallback(
          BiweeklyFollowUpTEC.mMuscleMassController.text, cmfu.mMuscleMass),
    );

    // Save the ClientMonthlyFollowUp object
    await context
        .read<ClientMonthlyFollowUpProvider>()
        .createClientMonthlyFollowUp(clientMonthlyFollowUp);

    // Update the client's weight
    if (newWeight != null) {
      c.mWeight = newWeight;
      await context.read<ClientProvider>().updateClient(c);
    }

    return true;
  } on Exception catch (e) {
    debugPrint('Error creating BiweeklyFollowUp: $e');
    return false;
  }
}

bool verifyBiweeklyRequiredFields(BuildContext context) {
  final requiredFields = {
    BiweeklyFollowUpTEC.mWeightController: 'الوزن',
    BiweeklyFollowUpTEC.mPBFController: 'نسبة الدهون',
  };

  for (var field in requiredFields.entries) {
    if (field.key.text.isEmpty) {
      showRequiredFieldSnackBar(context, field.value);
      return false;
    }
  }
  return true;
}

bool verifyBiweeklyFieldsDataType(BuildContext context) {
  bool isValid = true;

  final controllersWithMessages = [
    {
      'controller': BiweeklyFollowUpTEC.mWeightController,
      'message': 'الوزن',
    },
    {
      'controller': BiweeklyFollowUpTEC.mPBFController,
      'message': 'نسبة الدهون في الجسم',
    },
    {
      'controller': BiweeklyFollowUpTEC.mMaxWeightController,
      'message': 'الوزن الأقصى',
    },
    {
      'controller': BiweeklyFollowUpTEC.mOptimalWeightController,
      'message': 'الوزن المثالي',
    },
    {
      'controller': BiweeklyFollowUpTEC.mBMRController,
      'message': 'حد الحرق الأدنى',
    },
    {
      'controller': BiweeklyFollowUpTEC.mMaxCaloriesController,
      'message': 'السعرات الحرارية القصوى',
    },
    {
      'controller': BiweeklyFollowUpTEC.mDailyCaloriesController,
      'message': 'السعرات الحرارية اليومية',
    },
    {
      'controller': BiweeklyFollowUpTEC.mMuscleMassController,
      'message': 'كتلة العضلات',
    },
  ];

  for (var item in controllersWithMessages) {
    if (!isNumOnly((item['controller'] as TextEditingController).text)) {
      showInvalidDataTypeSnackBar(context, item['message'] as String);
      isValid = false;
    }
  }

  return isValid;
}