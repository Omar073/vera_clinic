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

import '../../Core/Services/DebugLoggerService.dart';
Future<bool> createBiweeklyFollowUp(
    Client c, ClientMonthlyFollowUp cmfu, BuildContext context) async {
  try {
    final weightText = BiweeklyFollowUpTEC.mWeightController.text.trim();
    final parsedWeight = double.tryParse(weightText);
    final double? normalizedWeight = (parsedWeight != null && parsedWeight > 0)
        ? normalizeToDecimals(parsedWeight, 1)
        : null;
    final double? weightForCalculation = normalizedWeight ?? c.mWeight;

    final clientMonthlyFollowUp =
        _buildMonthlyFollowUpRecord(c, cmfu, weightForCalculation);

    await context
        .read<ClientMonthlyFollowUpProvider>()
        .createClientMonthlyFollowUp(clientMonthlyFollowUp);

    await _updateClientData(
      c,
      clientMonthlyFollowUp,
      normalizedWeight,
      context,
    );

    return true;
  } on Exception catch (e) {
    mDebug('Error creating BiweeklyFollowUp: $e');
    return false;
  }
}

ClientMonthlyFollowUp _buildMonthlyFollowUpRecord(
    Client c, ClientMonthlyFollowUp cmfu, double? newWeight) {
  double bmi = cmfu.mBMI ?? 0.0;
  if (c.mHeight != null && c.mHeight! > 0 && newWeight != null) {
    bmi = normalizeBmi(newWeight / ((c.mHeight! / 100) * (c.mHeight! / 100)));
  }

  return ClientMonthlyFollowUp(
    clientMonthlyFollowUpId: '',
    clientId: c.mClientId,
    bmi: normalizeBmi(bmi),
    pbf: BiweeklyFollowUpTEC.mPBFController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mPBFController.text),
    water: BiweeklyFollowUpTEC.mWaterController.text.isEmpty
        ? null
        : BiweeklyFollowUpTEC.mWaterController.text,
    maxWeight: BiweeklyFollowUpTEC.mMaxWeightController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mMaxWeightController.text),
    optimalWeight: BiweeklyFollowUpTEC.mOptimalWeightController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mOptimalWeightController.text),
    bmr: BiweeklyFollowUpTEC.mBMRController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mBMRController.text),
    maxCalories: BiweeklyFollowUpTEC.mMaxCaloriesController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mMaxCaloriesController.text),
    dailyCalories: BiweeklyFollowUpTEC.mDailyCaloriesController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mDailyCaloriesController.text),
    muscleMass: BiweeklyFollowUpTEC.mMuscleMassController.text.isEmpty
        ? null
        : double.tryParse(BiweeklyFollowUpTEC.mMuscleMassController.text),
    date: DateTime.now(),
    notes: BiweeklyFollowUpTEC.mNotesController.text.isEmpty
        ? null
        : BiweeklyFollowUpTEC.mNotesController.text,
  );
}

Future<void> _updateClientData(
  Client c,
  ClientMonthlyFollowUp clientMonthlyFollowUp,
  double? updatedWeight,
  BuildContext context,
) async {
  bool shouldPersist = false;

  if (clientMonthlyFollowUp.mClientMonthlyFollowUpId.isNotEmpty) {
    c.mClientLastMonthlyFollowUpId =
        clientMonthlyFollowUp.mClientMonthlyFollowUpId;
    shouldPersist = true;
  }

  if (updatedWeight != null && updatedWeight > 0) {
    c.mWeight = updatedWeight;
    shouldPersist = true;
  }

  if (shouldPersist) {
    await context.read<ClientProvider>().updateClient(c);
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
