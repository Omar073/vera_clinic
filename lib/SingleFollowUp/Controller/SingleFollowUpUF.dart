import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/View/PopUps/InvalidDataTypeSnackBar.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../../Core/View/PopUps/RequiredFieldSnackBar.dart';
import 'SingleFollowUpTEC.dart';

String getAge(DateTime? birthDate) {
  if (birthDate == null) return 'مجهول';
  final now = DateTime.now();
  final age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    return (age - 1).toString();
  }
  return age.toString();
}

Future<bool> createSingleFollowUp(Client client, BuildContext context) async {
  try {
    double weight = double.tryParse(
            SingleFollowUpTEC.singleFollowUpWeightController.text) ??
        0.0;
    double bmi = 0.0;
    if (client.mHeight != null && client.mHeight! > 0) {
      bmi = weight / ((client.mHeight! / 100) * (client.mHeight! / 100));
    }

    Visit visit = Visit(
      visitId: '',
      clientId: client.mClientId,
      date: DateTime.now(),
      diet: SingleFollowUpTEC.singleFollowUpDietController.text,
      weight: weight,
      bmi: bmi,
      visitNotes: SingleFollowUpTEC.singleFollowUpNotesController.text,
    );

    await context.read<VisitProvider>().createVisit(visit);
    return true;
  } catch (e) {
    debugPrint('Error creating SingleFollowUp: $e');
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
