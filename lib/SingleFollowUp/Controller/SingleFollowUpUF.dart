import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/View/PopUps/InvalidDataTypeSnackBar.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Controller/Providers/ClientProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../../Core/View/PopUps/RequiredFieldSnackBar.dart';
import 'SingleFollowUpTEC.dart';

import '../../Core/Services/DebugLoggerService.dart';
Future<bool> createSingleFollowUp(Client client, BuildContext context) async {
  try {
    final weightText =
        SingleFollowUpTEC.singleFollowUpWeightController.text.trim();
    double weight = double.tryParse(weightText) ?? 0.0;
    double bmi = 0.0;
    final height = client.mHeight;
    if (height != null && height > 0) {
      bmi = weight / ((height / 100) * (height / 100));
    }

    Visit visit = Visit(
      visitId: '',
      clientId: client.mClientId,
      date: DateTime.now(),
      diet: SingleFollowUpTEC.singleFollowUpDietController.text,
      weight: weight,
      bmi: double.parse(bmi.toStringAsFixed(3)),
      visitNotes: SingleFollowUpTEC.singleFollowUpNotesController.text,
    );

    await context.read<VisitProvider>().createVisit(visit);

    bool shouldUpdateClient = false;

    // Ensure last visit is updated if this is the latest (created now)
    if (visit.mVisitId.isNotEmpty) {
      client.mLastVisitId = visit.mVisitId;
      shouldUpdateClient = true;
    }

    if (weight > 0) {
      client.mWeight = normalizeToDecimals(weight, 1);
      shouldUpdateClient = true;
    }

    final diet = SingleFollowUpTEC.singleFollowUpDietController.text.trim();
    if (diet.isNotEmpty) {
      client.mDiet = diet;
      shouldUpdateClient = true;
    }

    if (shouldUpdateClient) {
      await context.read<ClientProvider>().updateClient(client);
    }
    return true;
  } catch (e) {
    mDebug('Error creating SingleFollowUp: $e');
    return false;
  }
}

bool verifySingleFollowUpRequiredFields(BuildContext context) {
  final requiredFields = {
    SingleFollowUpTEC.singleFollowUpWeightController: 'الوزن',
  };

  for (var field in requiredFields.entries) {
    if (field.key.text.isEmpty) {
      showRequiredFieldSnackBar(context, field.value);
      return false;
    }
  }
  return true;
}

bool verifySingleFollowUpFieldsDataType(BuildContext context) {
  bool isValid = true;

  final controllersWithMessages = [
    {
      'controller': SingleFollowUpTEC.singleFollowUpWeightController,
      'message': 'الوزن',
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
